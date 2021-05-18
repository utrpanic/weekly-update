package com.weeklyupdate.oldmagician;

import org.junit.Test;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.core.Is.is;

public class OldMagicianTest {

    @Test
    public void testCase1() throws Exception {
        OldMagician oldMagician = new OldMagician();
        oldMagician.init("3 1");

        assertThat(oldMagician.getOutput(), is("BLACK"));
    }

    @Test
    public void testCase2() throws Exception {
        OldMagician oldMagician = new OldMagician();
        oldMagician.init("3 6");

        assertThat(oldMagician.getOutput(), is("WHITE"));
    }
}
