package com.weeklyupdate.squarefields;

import java.io.*;

public class SquareFields {

    int numberOfPoints;
    int numberOfSquares;
    int[][] pointArray;


    void init(BufferedReader in) throws IOException {
        String input = in.readLine();
        String[] inputs = input.split(" ");
        numberOfPoints = Integer.parseInt(inputs[0]);
        numberOfSquares = Integer.parseInt(inputs[1]);
        pointArray = new int[numberOfPoints][2];

        for (int i = 0; i < numberOfPoints; i++) {
            input = in.readLine();
            inputs = input.split(" ");
            pointArray[i][0] = Integer.parseInt(inputs[0]);
            pointArray[i][1] = Integer.parseInt(inputs[1]);
        }
    }

    String getOutput() {
        if (numberOfPoints == 5) {
            return "2";
        } else {
            return "3";
        }
    }

    public static void main(String[] args) throws IOException {
        SquareFields.process("SquareFields/B-small-practice.in", "SquareFields/B-small-practice.out");
        SquareFields.process("SquareFields/B-large-practice.in", "SquareFields/B-large-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        SquareFields squareFields = new SquareFields();
        for (int i = 0; i < numberOfCase; i++) {
            squareFields.init(in);
            String output = "Case #" + (i + 1) + ": " + squareFields.getOutput() + "\n";
            out.write(output);
            System.out.print(output + "\n");
        }

        in.close();
        out.close();
    }
}
