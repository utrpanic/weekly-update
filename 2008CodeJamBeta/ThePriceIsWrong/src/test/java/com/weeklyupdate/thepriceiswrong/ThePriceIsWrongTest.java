package com.weeklyupdate.thepriceiswrong;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class ThePriceIsWrongTest {

    @Test
    public void testCase1() throws Exception {
        ThePriceIsWrong thePriceIsWrong = new ThePriceIsWrong();
        thePriceIsWrong.initOrder("code jam foo bar google");
        thePriceIsWrong.initGuess("20 15 40 30 60");
        assertThat(thePriceIsWrong.getOutput(), is("bar code"));
    }
}
