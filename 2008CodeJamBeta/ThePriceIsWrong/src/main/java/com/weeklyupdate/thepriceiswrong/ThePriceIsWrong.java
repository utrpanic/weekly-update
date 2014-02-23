package com.weeklyupdate.thepriceiswrong;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;

public class ThePriceIsWrong {

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
        changedGuesses = new ArrayList<String>();
        for (int i = start; i < products.length - 1; i++) {
            if (guesses[i] > guesses[i + 1]) {
                if (i == start && i != 0) {
                    ThePriceIsWrong changeNext = new ThePriceIsWrong(this);
                    changeNext.guesses[i + 1] = changeNext.guesses[i] + 0.01;
                    changeNext.rearrangeGuesses(i + 1);
                    changedGuesses = changeNext.changedGuesses;
                    changedGuesses.add(products[i + 1]);
                } else {
                    ThePriceIsWrong changeCurrent = new ThePriceIsWrong(this);
                    changeCurrent.guesses[i] = changeCurrent.guesses[i + 1] - 0.01;
                    changeCurrent.rearrangeGuesses(i + 1);
                    ThePriceIsWrong changeNext = new ThePriceIsWrong(this);
                    changeNext.guesses[i + 1] = changeNext.guesses[i] + 0.01;
                    changeNext.rearrangeGuesses(i + 1);

                    if (changeCurrent.changedGuesses.size() < changeNext.changedGuesses.size()) {
                        changedGuesses = changeCurrent.changedGuesses;
                        changedGuesses.add(products[i]);
                    } else if (changeCurrent.changedGuesses.size() > changeNext.changedGuesses.size()) {
                        changedGuesses = changeNext.changedGuesses;
                        changedGuesses.add(products[i + 1]);
                    } else {
                        if (changeCurrent.changedGuesses.size() == 0) {
                            String changedProduct = products[i].compareTo(products[i + 1]) < 0 ? products[i] : products[i + 1];
                            changedGuesses.add(changedProduct);
                        } else {
                            String current = changeCurrent.getChangedGuessesString();
                            String next = changeNext.getChangedGuessesString();
                            if (current.compareTo(next) < 0) {
                                changedGuesses = changeCurrent.changedGuesses;
                                changedGuesses.add(products[i]);
                            } else if (current.compareTo(next) > 0) {
                                changedGuesses = changeNext.changedGuesses;
                                changedGuesses.add(products[i + 1]);
                            } else {
                                changedGuesses = changeCurrent.changedGuesses;
                                String changedProduct = products[i].compareTo(products[i + 1]) < 0 ? products[i] : products[i + 1];
                                changedGuesses.add(changedProduct);
                            }
                        }
                    }
                }
                break;
            }
        }

    }

    private boolean isCheckedGuess(double guess) {
        int temp = (int) (guess * 100);
        return temp % 100 != 0;
    }


}
