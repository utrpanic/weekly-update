package com.weeklyupdate.magictrick;

import java.io.*;
import java.util.ArrayList;

public class MagicTrick {

    int rowAtFirstDeck;
    int rowAtSecondDeck;

    int[][] firstDeck = new int[4][4];
    int[][] secondDeck = new int[4][4];

    void initFirstRow(String input) {
        rowAtFirstDeck = Integer.parseInt(input) - 1;
    }

    void initSecondRow(String input) {
        rowAtSecondDeck = Integer.parseInt(input) - 1;
    }

    void initFirstDeck(int row, String input) {
        String[] record = input.split(" ");
        for (int i = 0; i < 4; i++) {
            firstDeck[row][i] = Integer.parseInt(record[i]);
        }
    }

    void initSecondDeck(int row, String input) {
        String[] record = input.split(" ");
        for (int i = 0; i < 4; i++) {
            secondDeck[row][i] = Integer.parseInt(record[i]);
        }
    }

    String getOutput() {
        ArrayList<Integer> matchedCards = new ArrayList<Integer>();
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                if (firstDeck[rowAtFirstDeck][i] == secondDeck[rowAtSecondDeck][j]) {
                    matchedCards.add(firstDeck[rowAtFirstDeck][i]);
                }
            }
        }

        if (matchedCards.size() > 1) {
            return "Bad magician!";
        } else if (matchedCards.size() == 0) {
            return "Volunteer cheated!";
        } else {
            return matchedCards.get(0).toString();
        }
    }

    public static void main(String[] args) throws IOException {
        MagicTrick.process("MagicTrick/A-small-practice.in", "MagicTrick/A-small-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        MagicTrick magicTrick = new MagicTrick();
        for (int i = 0; i < numberOfCase; i++) {
            magicTrick.initFirstRow(in.readLine());
            for (int j = 0; j < 4; j++) {
                magicTrick.initFirstDeck(j, in.readLine());
            }
            magicTrick.initSecondRow(in.readLine());
            for (int j = 0; j < 4; j++) {
                magicTrick.initSecondDeck(j, in.readLine());
            }
            String output = "Case #" + (i + 1) + ": " + magicTrick.getOutput() + "\n";
            out.write(output);
            System.out.print(output + "\n");
        }

        in.close();
        out.close();
    }

}
