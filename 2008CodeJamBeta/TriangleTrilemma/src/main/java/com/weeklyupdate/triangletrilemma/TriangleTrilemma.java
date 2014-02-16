package com.weeklyupdate.triangletrilemma;

import java.io.*;
import java.util.Arrays;

public class TriangleTrilemma {

    private int x1, y1, x2, y2, x3, y3;
    private long[] squareOfLines;
    private double perpendicularLine;

    public static void main(String[] args) throws IOException {
        TriangleTrilemma.process("TriangleTrilemma/A-small-practice.in", "TriangleTrilemma/A-small-practice.out");
        TriangleTrilemma.process("TriangleTrilemma/A-large-practice.in", "TriangleTrilemma/A-large-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        TriangleTrilemma triangleTrilemma = new TriangleTrilemma();
        for (int i = 0; i < numberOfCase; i++) {
            String params = in.readLine();
            triangleTrilemma.init(params);
            String output = "Case #" + (i + 1) + ": " + triangleTrilemma.getOutput() + "\n";
            out.write(output);
            System.out.print(output);
        }

        in.close();
        out.close();
    }

    void init(String params) {
        System.out.println(params);
        String[] param = params.split(" ");
        x1 = Integer.parseInt(param[0]);
        y1 = Integer.parseInt(param[1]);
        x2 = Integer.parseInt(param[2]);
        y2 = Integer.parseInt(param[3]);
        x3 = Integer.parseInt(param[4]);
        y3 = Integer.parseInt(param[5]);
    }

    String getOutput() {
        calculateLines();

        if (onSameLine()) {
            return "not a triangle";
        }

        String classOfRelativeLength = getClassOfRelativeLength();

        String classOfAngle = getClassOfAngle();

        return classOfRelativeLength + " " + classOfAngle + " triangle";
    }

    private void calculateLines() {
        squareOfLines = new long[3];
        squareOfLines[0] = (long) (Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
        squareOfLines[1] = (long) (Math.pow(x2 - x3, 2) + Math.pow(y2 - y3, 2));
        squareOfLines[2] = (long) (Math.pow(x3 - x1, 2) + Math.pow(y3 - y1, 2));
        Arrays.sort(squareOfLines); // Ascent order
        perpendicularLine = Math.sqrt(((squareOfLines[0] * squareOfLines[1]) / (double) squareOfLines[2]));

        System.out.println("line1: " + squareOfLines[0] + ", line2: " + squareOfLines[1] + ", line3: " + squareOfLines[2] + ", perpendicular: " + perpendicularLine);
    }

    private boolean onSameLine() {
        if (x1 == x2 && x2 == x3 || y1 == y2 && y2 == y3 || (squareOfLines[0] == 0 || squareOfLines[1] == 0 || squareOfLines[2] == 0)) {
            return true;
        }
        if (squareOfLines[2] == squareOfLines[0] + squareOfLines[1]) {
            return false;
        }
        long gradient12 = (y1 - y2) * (x1 - x3);
        long gradient13 = (y1 - y3) * (x1 - x2);
        System.out.println("gradient12: " + gradient12 + ", gradient13: " + gradient13);
        return gradient12 == gradient13;
    }

    private String getClassOfRelativeLength() {
        if (squareOfLines[0] == squareOfLines[1] || squareOfLines[1] == squareOfLines[2]) {
            return "isosceles";
        } else {
            return "scalene";
        }
    }

    private String getClassOfAngle() {
        double sinA = perpendicularLine / Math.sqrt(squareOfLines[0]);
        double sinB = perpendicularLine / Math.sqrt(squareOfLines[1]);
        double angAInDegree = Math.toDegrees(Math.asin(sinA));
        double angBInDegree = Math.toDegrees(Math.asin(sinB));

        double sumOfTwoSmallDegree = (angAInDegree + angBInDegree);
        System.out.println("SinA: " + sinA + ", SinB: " + sinB);
        System.out.println("AngA: " + angAInDegree + ", AngB: " + angBInDegree + ", Sum: " + sumOfTwoSmallDegree);
        if (squareOfLines[0] + squareOfLines[1] == squareOfLines[2]) {
            return "right";
        } else if (sumOfTwoSmallDegree < 90) {
            return "obtuse";
        } else {
            return "acute";
        }
    }


}
