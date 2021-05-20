package com.weeklyupdate.thepriceiswrong;

import org.junit.Ignore;
import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class ThePriceIsWrongTest {

    @Test
//    @Ignore
    public void testCase1() throws Exception {
        ThePriceIsWrong thePriceIsWrong = new ThePriceIsWrong();
        thePriceIsWrong.initOrder("code jam foo bar google");
        thePriceIsWrong.initGuess("20 15 40 30 60");
        assertThat(thePriceIsWrong.getOutput(), is("bar code"));
    }

    @Test
//    @Ignore
    public void testCase3() throws Exception {
        ThePriceIsWrong thePriceIsWrong = new ThePriceIsWrong();
        thePriceIsWrong.initOrder("code jam foo bar google");
        thePriceIsWrong.initGuess("20 70 40 30 60");
        assertThat(thePriceIsWrong.getOutput(), is("bar jam"));
    }

    @Test
//    @Ignore
    public void testCase5() throws Exception {
        ThePriceIsWrong thePriceIsWrong = new ThePriceIsWrong();
        thePriceIsWrong.initOrder("code jam foo bar google");
        thePriceIsWrong.initGuess("60 30 40 15 20");
        assertThat(thePriceIsWrong.getOutput(), is("bar code google"));
    }

    @Test
//    @Ignore
    public void testCase57() throws Exception {
        ThePriceIsWrong thePriceIsWrong = new ThePriceIsWrong();
        thePriceIsWrong.initOrder("wing band ball rail plough farm shelf tongue");
        thePriceIsWrong.initGuess("85 100 79 74 34 65 20 38");
        assertThat(thePriceIsWrong.getOutput(), is("ball band farm plough rail wing"));
    }

}
