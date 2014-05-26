package com.weeklyupdate.traintimetable;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;

public class TrainTimetable {

    ArrayList<DepartureOrArrival> mTimetable;

    void initTrainTimetable(BufferedReader in) throws IOException, ParseException {
        int turnAroundTime = Integer.parseInt(in.readLine());
        int numberOfDepartureFromA, numberOfDepartureFromB;
        String[] numberOfDepartures = in.readLine().split(" ");
        numberOfDepartureFromA = Integer.parseInt(numberOfDepartures[0]);
        numberOfDepartureFromB = Integer.parseInt(numberOfDepartures[1]);
        mTimetable = new ArrayList<DepartureOrArrival>();
        for (int i = 0; i < numberOfDepartureFromA; i++) {
            String[] times = in.readLine().split(" ");
            mTimetable.add(new Departure(Station.STATION_A, times[0]));
            mTimetable.add(new Arrival(Station.STATION_B, times[1], turnAroundTime));
        }
        for (int i = 0; i < numberOfDepartureFromB; i++) {
            String[] times = in.readLine().split(" ");
            mTimetable.add(new Departure(Station.STATION_B, times[0]));
            mTimetable.add(new Arrival(Station.STATION_A, times[1], turnAroundTime));
        }

        Collections.sort(mTimetable, new Comparator<DepartureOrArrival>() {
            @Override
            public int compare(DepartureOrArrival departureOrArrival1, DepartureOrArrival departureOrArrival2) {
                int diff = (int) (departureOrArrival1.mTime.getTime() - departureOrArrival2.mTime.getTime());
                if (diff != 0) {
                    return diff;
                } else {
                    return departureOrArrival2.mState.ordinal() - departureOrArrival1.mState.ordinal();
                }
            }
        });
    }

    String getOutput() {
        int trainAtStationA = 0;
        int trainAtStationB = 0;
        int newTrainNeededA = 0;
        int newTrainNeededB = 0;
        for (DepartureOrArrival time: mTimetable) {
            if (time.mState == State.DEPARTURE) {
                if (time.mStation == Station.STATION_A) {
                    if (trainAtStationA == 0) {
                        newTrainNeededA++;
                    } else {
                        trainAtStationA--;
                    }
                } else if (time.mStation == Station.STATION_B) {
                    if (trainAtStationB == 0) {
                        newTrainNeededB++;
                    } else {
                        trainAtStationB--;
                    }
                }
            } else if (time.mState == State.ARRIVAL) {
                if (time.mStation == Station.STATION_A) {
                    trainAtStationA++;
                } else if (time.mStation == Station.STATION_B) {
                    trainAtStationB++;
                }
            }
        }
        return newTrainNeededA + " " + newTrainNeededB;
    }

    public static void main(String[] args) throws IOException, ParseException {
        TrainTimetable.process("TrainTimetable/B-small-practice.in", "TrainTimetable/B-small-practice.out");
        TrainTimetable.process("TrainTimetable/B-large-practice.in", "TrainTimetable/B-large-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException, ParseException {
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

enum State {
    DEPARTURE,
    ARRIVAL,
}

enum Station {
    STATION_A,
    STATION_B,
}

class DepartureOrArrival {
    State mState;
    Station mStation;
    Date mTime;
    static SimpleDateFormat sDateFormat = new SimpleDateFormat("HH:mm");

    public DepartureOrArrival(Station station, String time) throws ParseException {
        mStation = station;
        mTime = sDateFormat.parse(time);
    }
}

class Departure extends DepartureOrArrival {
    public Departure(Station station, String time) throws ParseException {
        super(station, time);
        mState = State.DEPARTURE;
    }
}

class Arrival extends DepartureOrArrival {
    public Arrival(Station station, String time, int turnArroundTime) throws ParseException {
        super(station, time);
        mState = State.ARRIVAL;
        mTime = new Date(mTime.getTime() + (turnArroundTime * 60000));
    }
}
