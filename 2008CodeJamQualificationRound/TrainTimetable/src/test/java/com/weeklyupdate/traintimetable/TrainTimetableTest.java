package com.weeklyupdate.traintimetable;

import org.junit.Test;

import java.io.BufferedReader;
import java.io.StringReader;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class TrainTimetableTest {

    @Test
    public void testcaseSample1() throws Exception {
        BufferedReader bufferedReader = new BufferedReader(new StringReader(
                "5\n" +
                        "3 2\n" +
                        "09:00 12:00\n" +
                        "10:00 13:00\n" +
                        "11:00 12:30\n" +
                        "12:02 15:00\n" +
                        "09:00 10:30\n"
        ));

        TrainTimetable trainTimetable = new TrainTimetable();
        trainTimetable.initTrainTimetable(bufferedReader);
        assertThat(trainTimetable.getOutput(), is("2 2"));
    }

    @Test
    public void testcaseSample2() throws Exception {
        BufferedReader bufferedReader = new BufferedReader(new StringReader(
                "2\n" +
                        "2 0\n" +
                        "09:00 09:01\n" +
                        "12:00 12:02"
        ));

        TrainTimetable trainTimetable = new TrainTimetable();
        trainTimetable.initTrainTimetable(bufferedReader);
        assertThat(trainTimetable.getOutput(), is("2 0"));
    }

    @Test
    public void testcaseSmall1() throws Exception {
        BufferedReader bufferedReader = new BufferedReader(new StringReader(
                "0\n" +
                        "1 2\n" +
                        "01:40 01:41\n" +
                        "01:39 01:40\n" +
                        "01:40 01:41"
        ));

        TrainTimetable trainTimetable = new TrainTimetable();
        trainTimetable.initTrainTimetable(bufferedReader);
        assertThat(trainTimetable.getOutput(), is("0 2"));
    }

}
