package com.weeklyupdate.flyswatter;

import org.junit.Test;

import java.io.BufferedReader;
import java.io.StringReader;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class FlySwatterTest {

    @Test
    public void testcaseSample1() throws Exception {
        BufferedReader bufferedReader = new BufferedReader(new StringReader(
                "0.25 1.0 0.1 0.01 0.5"
        ));
        FlySwatter flySwatter = new FlySwatter();
        flySwatter.init(bufferedReader);
        assertThat(flySwatter.getOutput(), is("1.000000"));
    }

    @Test
    public void testcaseSample2() throws Exception {
        BufferedReader bufferedReader = new BufferedReader(new StringReader(
                "0.25 1.0 0.1 0.01 0.9"
        ));
        FlySwatter flySwatter = new FlySwatter();
        flySwatter.init(bufferedReader);
        assertThat(flySwatter.getOutput(), is("0.910015"));
    }

    @Test
    public void testcaseSample3() throws Exception {
        BufferedReader bufferedReader = new BufferedReader(new StringReader(
                "0.00001 10000 0.00001 0.00001 1000"
        ));
        FlySwatter flySwatter = new FlySwatter();
        flySwatter.init(bufferedReader);
        assertThat(flySwatter.getOutput(), is("0.000000"));
    }

    @Test
    public void testcaseSample4() throws Exception {
        BufferedReader bufferedReader = new BufferedReader(new StringReader(
                "0.4 10000 0.00001 0.00001 700"
        ));
        FlySwatter flySwatter = new FlySwatter();
        flySwatter.init(bufferedReader);
        assertThat(flySwatter.getOutput(), is("0.002371"));
    }

    @Test
    public void testcaseSample5() throws Exception {
        BufferedReader bufferedReader = new BufferedReader(new StringReader(
                "1 100 1 1 10"
        ));
        FlySwatter flySwatter = new FlySwatter();
        flySwatter.init(bufferedReader);
        assertThat(flySwatter.getOutput(), is("0.573972"));
    }
}
