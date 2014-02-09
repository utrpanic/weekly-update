package com.weeklyupdate.triangletrilemma;

import java.io.*;
import java.util.Arrays;

public class TriangleTrilemma {

    private int x1, y1, x2, y2, x3, y3;
    private double[] lines;

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
            out.write("Case #" + (i + 1) + ": " + triangleTrilemma.getOutput() + "\n");
        }

        in.close();
        out.close();
    }

    void init(String params) {
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

        if (lines[0] + lines[1] == lines[2]) {
            return "not a triangle";
        }

        String classOfRelativeLength = getClassOfRelativeLength();

        String classOfAngle = getClassOfAngle();

        return classOfRelativeLength + " " + classOfAngle + " triangle";
    }

    private void calculateLines() {
        lines = new double[3];
        lines[0] = Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
        lines[1] = Math.sqrt(Math.pow(x2 - x3, 2) + Math.pow(y2 - y3, 2));
        lines[2] = Math.sqrt(Math.pow(x3 - x1, 2) + Math.pow(y3 - y1, 2));
        Arrays.sort(lines); // Ascent order
    }

    private String getClassOfRelativeLength() {
        if (lines[0] == lines[1] || lines[1] == lines[2]) {
            return "isosceles";
        } else {
            return "scalene";
        }
    }

    private String getClassOfAngle() {
        double cosA = (lines[2] * (Math.pow(lines[0], 2) / (Math.pow(lines[0], 2) + Math.pow(lines[1], 2)))) / lines[0];
        double cosB = (lines[2] * (Math.pow(lines[1], 2) / (Math.pow(lines[0], 2) + Math.pow(lines[1], 2)))) / lines[1];
        double angA = Math.toDegrees(Math.acos(cosA));
        double angB = Math.toDegrees(Math.acos(cosB));
        int sumOfTwoSmallDegree = (int) (angA + angB + 0.000001);
//        System.out.println("line1: " + lines[0] + ", line2: " + lines[1] + ", line3: " + lines[2]);
//        System.out.println("CosA: " + cosA + ", cosB: " + cosB);
//        System.out.println("AngA: " + angA + ", AngB: " + angB);
        if (sumOfTwoSmallDegree == 90) {
            return "right";
        } else if (sumOfTwoSmallDegree < 90) {
            return "obtuse";
        } else {
            return "acute";
        }
    }


}
