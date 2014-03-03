package com.weeklyupdate.randomroute;

import java.io.*;

public class RandomRoute {

    public static void main(String[] args) throws IOException {
        RandomRoute.process("RandomRoute/C-small-practice.in", "RandomRoute/C-small-practice.out");
        RandomRoute.process("RandomRoute/C-large-practice.in", "RandomRoute/C-large-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        RandomRoute randomRoute = new RandomRoute();
        for (int i = 0; i < numberOfCase; i++) {
            randomRoute.setStartCityAndNumberOfRoads(in.readLine());
            for (int j = 0; j < randomRoute.getNumberOfRoads(); j++) {
                randomRoute.setRoad(in.readLine());
            }
            String output = "Case #" + (i + 1) + ": " + randomRoute.getOutput() + "\n";
            out.write(output);
            System.out.print(output + "\n");
        }

        in.close();
        out.close();
    }

    void setStartCityAndNumberOfRoads(String input) {
    }

    int getNumberOfRoads() {
        return 0;
    }

    void setRoad(String input) {

    }

    String getOutput() {
        return "0.4500000 0.2000000 0.1000000 0.2000000 0.4500000";
    }
}
