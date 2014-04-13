package com.weeklyupdate.magictrick;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class MagicTrickTest {

    @Test
    public void testcase1() throws Exception {
        MagicTrick magicTrick = new MagicTrick();
        magicTrick.initFirstRow("2");
        magicTrick.initFirstDeck(0, "1 2 3 4");
        magicTrick.initFirstDeck(1, "5 6 7 8");
        magicTrick.initFirstDeck(2, "9 10 11 12");
        magicTrick.initFirstDeck(3, "13 14 15 16");
        magicTrick.initSecondRow("3");
        magicTrick.initSecondDeck(0, "1 2 5 4");
        magicTrick.initSecondDeck(1, "3 11 6 15");
        magicTrick.initSecondDeck(2, "9 10 7 12");
        magicTrick.initSecondDeck(3, "13 14 8 16");

        assertThat(magicTrick.getOutput(), is("7"));
    }

    @Test
    public void testcase2() throws Exception {
        MagicTrick magicTrick = new MagicTrick();
        magicTrick.initFirstRow("2");
        magicTrick.initFirstDeck(0, "1 2 3 4");
        magicTrick.initFirstDeck(1, "5 6 7 8");
        magicTrick.initFirstDeck(2, "9 10 11 12");
        magicTrick.initFirstDeck(3, "13 14 15 16");
        magicTrick.initSecondRow("2");
        magicTrick.initSecondDeck(0, "1 2 3 4");
        magicTrick.initSecondDeck(1, "5 6 7 8");
        magicTrick.initSecondDeck(2, "9 10 11 12");
        magicTrick.initSecondDeck(3, "13 14 15 16");

        assertThat(magicTrick.getOutput(), is("Bad magician!"));
    }

    @Test
    public void testcase3() throws Exception {
        MagicTrick magicTrick = new MagicTrick();
        magicTrick.initFirstRow("2");
        magicTrick.initFirstDeck(0, "1 2 3 4");
        magicTrick.initFirstDeck(1, "5 6 7 8");
        magicTrick.initFirstDeck(2, "9 10 11 12");
        magicTrick.initFirstDeck(3, "13 14 15 16");
        magicTrick.initSecondRow("3");
        magicTrick.initSecondDeck(0, "1 2 3 4");
        magicTrick.initSecondDeck(1, "5 6 7 8");
        magicTrick.initSecondDeck(2, "9 10 11 12");
        magicTrick.initSecondDeck(3, "13 14 15 16");

        assertThat(magicTrick.getOutput(), is("Volunteer cheated!"));
    }

}
