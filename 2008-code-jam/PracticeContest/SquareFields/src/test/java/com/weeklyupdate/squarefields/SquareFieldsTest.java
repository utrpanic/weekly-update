package com.weeklyupdate.squarefields;

import org.junit.Test;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.core.Is.is;

public class SquareFieldsTest {

    @Test
    public void testcase1() throws Exception {
        SquareFields squareFields = new SquareFields();
        squareFields.numberOfPoints = 5;
        squareFields.numberOfSquares = 2;
        squareFields.pointArray = new int[5][2];
        squareFields.pointArray[0][0] = 1;
        squareFields.pointArray[0][1] = 1;
        squareFields.pointArray[1][0] = 2;
        squareFields.pointArray[1][1] = 2;
        squareFields.pointArray[2][0] = 3;
        squareFields.pointArray[2][1] = 3;
        squareFields.pointArray[3][0] = 6;
        squareFields.pointArray[3][1] = 6;
        squareFields.pointArray[4][0] = 7;
        squareFields.pointArray[4][1] = 8;

        assertThat(squareFields.getOutput(), is("2"));
    }

    @Test
    public void testcase2() throws Exception {
        SquareFields squareFields = new SquareFields();
        squareFields.numberOfPoints = 3;
        squareFields.numberOfSquares = 2;
        squareFields.pointArray = new int[3][2];
        squareFields.pointArray[0][0] = 3;
        squareFields.pointArray[0][1] = 3;
        squareFields.pointArray[1][0] = 3;
        squareFields.pointArray[1][1] = 6;
        squareFields.pointArray[2][0] = 6;
        squareFields.pointArray[2][1] = 9;

        assertThat(squareFields.getOutput(), is("3"));
    }
}
