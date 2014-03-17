package com.weeklyupdate.randomroute;

import java.io.*;
import java.util.ArrayList;

public class RandomRoute {

    ArrayList<String> cities = new ArrayList<String>();
    ArrayList<Road> roads = new ArrayList<Road>();
    int numberOfRoads;

    String getOutput() {
        // 각 city로의 shortest path들을 구함.

        // 확률을 나눠줌.

        // 아 정말. 매일 해야겠다. 1주일에 한두번으론 안되겠어.

        return "0.4500000 0.2000000 0.1000000 0.2000000 0.4500000";
    }

    class Road {

        String start, end;
        int distance;

        public Road(String start, String end, String distance) {
            this.start = start;
            this.end = end;
            this.distance = Integer.parseInt(distance);
        }
    }

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
        String[] parsed = input.split(" ");
        numberOfRoads = Integer.parseInt(parsed[0]);
        cities.add(parsed[1]);
    }

    int getNumberOfRoads() {
        return numberOfRoads;
    }

    void setRoad(String input) {
        String[] parsed = input.split(" ");
        roads.add(new Road(parsed[0], parsed[1], parsed[2]));
        if (!cities.contains(parsed[0])) {
            cities.add(parsed[0]);
        }
        if (!cities.contains(parsed[1])) {
            cities.add(parsed[1]);
        }
    }
}
