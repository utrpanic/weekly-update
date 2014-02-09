package com.weeklyupdate.triangletrilemma;

import org.junit.Before;
import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class TriangleTrilemmaTest {

    @Before
    public void setUp() throws Exception {


    }

    @Test
    public void testcase1() throws Exception {
        TriangleTrilemma triangleTrilemma = new TriangleTrilemma();
        triangleTrilemma.init("0 0 0 4 1 2");
        assertThat(triangleTrilemma.getOutput(), is("isosceles obtuse triangle"));
    }

    @Test
    public void testcase2() throws Exception {
        TriangleTrilemma triangleTrilemma = new TriangleTrilemma();
        triangleTrilemma.init("1 1 1 4 3 2");
        assertThat(triangleTrilemma.getOutput(), is("scalene acute triangle"));
    }

    @Test
    public void testcase3() throws Exception {
        TriangleTrilemma triangleTrilemma = new TriangleTrilemma();
        triangleTrilemma.init("2 2 2 4 4 3");
        assertThat(triangleTrilemma.getOutput(), is("isosceles acute triangle"));
    }

    @Test
    public void testcase4() throws Exception {
        TriangleTrilemma triangleTrilemma = new TriangleTrilemma();
        triangleTrilemma.init("3 3 3 4 5 3");
        assertThat(triangleTrilemma.getOutput(), is("scalene right triangle"));
    }

    @Test
    public void testcase5() throws Exception {
        TriangleTrilemma triangleTrilemma = new TriangleTrilemma();
        triangleTrilemma.init("4 4 4 5 5 6");
        assertThat(triangleTrilemma.getOutput(), is("scalene obtuse triangle"));
    }

    @Test
    public void testcase6() throws Exception {
        TriangleTrilemma triangleTrilemma = new TriangleTrilemma();
        triangleTrilemma.init("5 5 5 6 6 5");
        assertThat(triangleTrilemma.getOutput(), is("isosceles right triangle"));
    }

    @Test
    public void testcase7() throws Exception {
        TriangleTrilemma triangleTrilemma = new TriangleTrilemma();
        triangleTrilemma.init("6 6 6 7 6 8");
        assertThat(triangleTrilemma.getOutput(), is("not a triangle"));
    }

    @Test
    public void testcase8() throws Exception {
        TriangleTrilemma triangleTrilemma = new TriangleTrilemma();
        triangleTrilemma.init("7 7 7 7 7 7");
        assertThat(triangleTrilemma.getOutput(), is("not a triangle"));
    }

}
