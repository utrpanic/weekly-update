package com.weeklyupdate.savingtheuniverse;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class SavingTheUniverseTest {

    @Test
    public void testcase1() throws Exception {
        SavingTheUniverse savingTheUniverse = new SavingTheUniverse();
        savingTheUniverse.searchEngines = new String[] {"Yeehaw",
                                                        "NSM",
                                                        "Dont Ask",
                                                        "B9",
                                                        "Googol"};
        savingTheUniverse.queries = new String[] {"Yeehaw",
                                                  "Yeehaw",
                                                  "Googol",
                                                  "B9",
                                                  "Googol",
                                                  "NSM",
                                                  "B9",
                                                  "NSM",
                                                  "Dont Ask",
                                                  "Googol"};
        assertThat(savingTheUniverse.getOutput(), is("1"));
    }
}
