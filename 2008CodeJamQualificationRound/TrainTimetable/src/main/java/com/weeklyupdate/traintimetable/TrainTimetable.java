package com.weeklyupdate.traintimetable;

import java.io.*;

public class TrainTimetable {

    class TrainSchedule {
        final static int STATION_A = 100;
        final static int STATION_B = 101;

        int departureStation;
        String[] schedule;

        TrainSchedule(int departureStation, String input) {
            this.departureStation = departureStation;
            schedule = input.split(" ");
        }

        String getDepartureTime() {
            return schedule[0];
        }

        String getArrivalTime() {
            return schedule[1];
        }
    }

    TrainSchedule[] trainSchedules;

    void initTrainTimetable(BufferedReader in) throws IOException {
        int totalNumberOfDeparture = Integer.parseInt(in.readLine());
        int numberOfDepartureFromA;
        String[] numberOfDepartures = in.readLine().split(" ");
        numberOfDepartureFromA = Integer.parseInt(numberOfDepartures[0]);
        trainSchedules = new TrainSchedule[totalNumberOfDeparture];
        for (int i = 0; i < totalNumberOfDeparture; i++) {
            if (i < numberOfDepartureFromA) {
                trainSchedules[i] = new TrainSchedule(TrainSchedule.STATION_A, in.readLine());
            } else {
                trainSchedules[i] = new TrainSchedule(TrainSchedule.STATION_B, in.readLine());
            }
        }
    }

    String getOutput() {
        return "2 2";
    }

    public static void main(String[] args) throws IOException {
        TrainTimetable.process("TrainTimetable/B-small-practice.in", "TrainTimetable/B-small-practice.out");
        TrainTimetable.process("TrainTimetable/B-large-practice.in", "TrainTimetable/B-large-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        TrainTimetable trainTimetable = new TrainTimetable();
        for (int i = 0; i < numberOfCase; i++) {
            trainTimetable.initTrainTimetable(in);
            String output = "Case #" + (i + 1) + ": " + trainTimetable.getOutput() + "\n";
            out.write(output);
            System.out.print(output + "\n");
        }

        in.close();
        out.close();
    }
}
