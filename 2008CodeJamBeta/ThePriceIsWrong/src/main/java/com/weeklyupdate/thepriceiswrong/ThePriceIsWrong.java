package com.weeklyupdate.thepriceiswrong;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;

public class ThePriceIsWrong {

    static double UNIT_OF_CHANGE = 0.01;

    String[] products;
    double[] guesses;

    ArrayList<String> changedGuesses;

    public static void main(String[] args) throws IOException {
        ThePriceIsWrong.process("ThePriceIsWrong/B-small-practice.in", "ThePriceIsWrong/B-small-practice.out");
        ThePriceIsWrong.process("ThePriceIsWrong/B-large-practice.in", "ThePriceIsWrong/B-large-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        ThePriceIsWrong thePriceIsWrong = new ThePriceIsWrong();
        for (int i = 0; i < numberOfCase; i++) {
            thePriceIsWrong.initOrder(in.readLine());
            thePriceIsWrong.initGuess(in.readLine());
            String output = "Case #" + (i + 1) + ": " + thePriceIsWrong.getOutput() + "\n";
            out.write(output);
            System.out.print(output + "\n");
        }

        in.close();
        out.close();
    }

    public ThePriceIsWrong() {

    }

    public ThePriceIsWrong(ThePriceIsWrong thePriceIsWrong) {
        this.products = thePriceIsWrong.products;
        this.guesses = Arrays.copyOf(thePriceIsWrong.guesses, thePriceIsWrong.guesses.length);
    }

    void initOrder(String products) {
        this.products = products.split(" ");
        System.out.println(products);
    }

    void initGuess(String guesses) {
        System.out.println(guesses);
        String[] guessesInString = guesses.split(" ");
        this.guesses = new double[guessesInString.length];
        for (int i = 0; i < guessesInString.length; i++) {
            this.guesses[i] = Integer.parseInt(guessesInString[i]);
        }
    }

    String getOutput() {
        rearrangeGuesses(0);
        return getChangedGuessesString();
    }

    String getChangedGuessesString() {
        String[] changedGuessesArray = new String[0];
        changedGuessesArray = changedGuesses.toArray(changedGuessesArray);
        Arrays.sort(changedGuessesArray);
        StringBuilder output = new StringBuilder();
        for (String changedGuess : changedGuessesArray) {
            output.append(changedGuess).append(" ");
        }
        return output.toString().trim();
    }

    private void rearrangeGuesses(int start) {
        for (int i = 1; i < start; i++) {
            if (guesses[i - 1] > guesses[i]) {
                changedGuesses = null;
                return;
            }
        }
        changedGuesses = new ArrayList<String>();
        for (int i = start; i < products.length; i++) {
            ThePriceIsWrong changeCurrent = new ThePriceIsWrong(this);
            if (i == 0) {
                changeCurrent.guesses[i] = UNIT_OF_CHANGE;
            } else {
                changeCurrent.guesses[i] = changeCurrent.guesses[i - 1] + UNIT_OF_CHANGE;
            }

            changeCurrent.rearrangeGuesses(i + 1);
            changeCurrent.changedGuesses.add(products[i]);
            rearrangeGuesses(i + 1);

            if (changeCurrent.compare(this) < 0) {
                changedGuesses = changeCurrent.changedGuesses;
            } else if (changeCurrent.compare(this) == 0) {
                String current = changeCurrent.getChangedGuessesString();
                if (current.compareTo(getChangedGuessesString()) < 0) {
                    changedGuesses = changeCurrent.changedGuesses;
                }
            }

            break;
        }

    }

    private int compare(ThePriceIsWrong thePriceIsWrong) {
        if (changedGuesses == null) {
            return 1;
        } else if (thePriceIsWrong.changedGuesses == null) {
            return -1;
        } else {
            return changedGuesses.size() - thePriceIsWrong.changedGuesses.size();
        }
    }

}
