import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;

public class Solution {

    public static void main(String[] args) throws IOException, ParseException {
        BufferedReader reader = new BufferedReader(
            new StringReader(
                "3\n" +
                TestCase.testCase1.input +
                TestCase.testCase2.input +
                TestCase.testCase3.input
            )
        );
        // BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int numberOfCase = Integer.valueOf(reader.readLine());
        for (int i = 0; i < numberOfCase; i++) {
            TrainTimetable trainTimetable = new TrainTimetable(reader);
            System.out.println("Case #" + (i + 1) + ": " + trainTimetable.getOutput());
        }
    }
}

class TrainTimetable {

    ArrayList<DepartureOrArrival> mTimetable;

    TrainTimetable(BufferedReader reader) throws IOException, ParseException {
        int turnAroundTime = Integer.parseInt(reader.readLine());
        int numberOfDepartureFromA, numberOfDepartureFromB;
        String[] numberOfDepartures = reader.readLine().split(" ");
        numberOfDepartureFromA = Integer.parseInt(numberOfDepartures[0]);
        numberOfDepartureFromB = Integer.parseInt(numberOfDepartures[1]);
        mTimetable = new ArrayList<DepartureOrArrival>();
        for (int i = 0; i < numberOfDepartureFromA; i++) {
            String[] times = reader.readLine().split(" ");
            mTimetable.add(new Departure(Station.STATION_A, times[0]));
            mTimetable.add(new Arrival(Station.STATION_B, times[1], turnAroundTime));
        }
        for (int i = 0; i < numberOfDepartureFromB; i++) {
            String[] times = reader.readLine().split(" ");
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

class TestCase {

    String input;
    
    TestCase(String input) {
        this.input = input;
    }

    static TestCase testCase1 = new TestCase(
        "5\n" +
        "3 2\n" +
        "09:00 12:00\n" +
        "10:00 13:00\n" +
        "11:00 12:30\n" +
        "12:02 15:00\n" +
        "09:00 10:30\n"
    ); // "2 2"

    static TestCase testCase2 = new TestCase(
        "2\n" +
        "2 0\n" +
        "09:00 09:01\n" +
        "12:00 12:02\n"
    ); // "2 0"

    static TestCase testCase3 = new TestCase(
        "0\n" +
        "1 2\n" +
        "01:40 01:41\n" +
        "01:39 01:40\n" +
        "01:40 01:41\n"
    ); // "0 2"
}
