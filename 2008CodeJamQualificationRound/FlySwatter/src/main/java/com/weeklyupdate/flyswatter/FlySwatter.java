package com.weeklyupdate.flyswatter;

import java.io.*;

public class FlySwatter {

    double fly;
    double radiusOfRacquet;
    double thickness;
    double radiusOfString;
    double gap;

    public static void main(String[] args) throws IOException {
        FlySwatter.process("FlySwatter/C-small-practice.in", "FlySwatter/C-small-practice.out");
        FlySwatter.process("FlySwatter/C-large-practice.in", "FlySwatter/C-large-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        FlySwatter flySwatter = new FlySwatter();
        for (int i = 0; i < numberOfCase; i++) {
            flySwatter.init(in);
            String output = "Case #" + (i + 1) + ": " + flySwatter.getOutput() + "\n";
            out.write(output);
            System.out.print(output + "\n");
        }

        in.close();
        out.close();
    }

    void init(BufferedReader in) throws IOException {
        String[] inputs = in.readLine().split(" ");
        fly = Double.parseDouble(inputs[0]);
        radiusOfRacquet = Double.parseDouble(inputs[1]);
        thickness = Double.parseDouble(inputs[2]);
        radiusOfString = Double.parseDouble(inputs[3]);
        gap = Double.parseDouble(inputs[4]);
    }

    String getOutput() {
        double areaOfRacquet = Math.PI * radiusOfRacquet * radiusOfRacquet;
        radiusOfRacquet -= thickness + fly;
        radiusOfString += fly;
        gap -= fly * 2;

        double bottomLeftOfGapX = radiusOfString;
        double bottomLeftOfGapY = radiusOfString;
        double totalAreaOfGap = 0;
        while (bottomLeftOfGapY <= radiusOfRacquet) {
            while (bottomLeftOfGapX <= radiusOfRacquet) {
                totalAreaOfGap += new Gap(bottomLeftOfGapX, bottomLeftOfGapY, gap, radiusOfRacquet).getArea();
                bottomLeftOfGapX += gap + radiusOfString * 2;
            }
            bottomLeftOfGapY += gap + radiusOfString * 2;
            bottomLeftOfGapX = radiusOfString;
        }

        double output = (areaOfRacquet - totalAreaOfGap * 4) / areaOfRacquet;

        return String.format("%.6f", output);
    }
}
