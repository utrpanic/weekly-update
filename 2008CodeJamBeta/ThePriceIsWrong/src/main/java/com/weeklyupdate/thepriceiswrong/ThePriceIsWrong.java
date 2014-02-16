package com.weeklyupdate.thepriceiswrong;

import java.io.*;

public class ThePriceIsWrong {

    String[] orders;
    int[] guesses;

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
            System.out.print(output);
        }

        in.close();
        out.close();
    }

    void initOrder(String orders) {
        this.orders = orders.split(" ");
        System.out.println(orders);
    }

    void initGuess(String guesses) {
        System.out.println(guesses);
        String[] guessesInString = guesses.split(" ");
        this.guesses = new int[guessesInString.length];
        for (int i = 0; i < guessesInString.length; i++) {
            this.guesses[i] = Integer.parseInt(guessesInString[i]);
        }
    }

    String getOutput() {
        return "bar code";
    }


}
