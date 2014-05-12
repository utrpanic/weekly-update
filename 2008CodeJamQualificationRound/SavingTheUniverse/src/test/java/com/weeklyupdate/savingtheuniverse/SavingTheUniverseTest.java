package com.weeklyupdate.savingtheuniverse;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class SavingTheUniverseTest {

    @Test
    public void testcaseSample1() throws Exception {
        SavingTheUniverse savingTheUniverse = new SavingTheUniverse();
        savingTheUniverse.searchEngines = new String[]{
                "Yeehaw",
                "NSM",
                "Dont Ask",
                "B9",
                "Googol",
        };
        savingTheUniverse.queries = new String[]{
                "Yeehaw",
                "Yeehaw",
                "Googol",
                "B9",
                "Googol",
                "NSM",
                "B9",
                "NSM",
                "Dont Ask",
                "Googol",
        };
        assertThat(savingTheUniverse.getOutput(), is("1"));
    }

    @Test
    public void testcaseSample2() throws Exception {
        SavingTheUniverse savingTheUniverse = new SavingTheUniverse();
        savingTheUniverse.searchEngines = new String[]{
                "Yeehaw",
                "NSM",
                "Dont Ask",
                "B9",
                "Googol",
        };
        savingTheUniverse.queries = new String[]{
                "Googol",
                "Dont Ask",
                "NSM",
                "NSM",
                "Yeehaw",
                "Yeehaw",
                "Googol",
        };
        assertThat(savingTheUniverse.getOutput(), is("0"));
    }

    @Test
    public void testcase3() throws Exception {
        SavingTheUniverse savingTheUniverse = new SavingTheUniverse();
        savingTheUniverse.searchEngines = new String[]{
                "Googol Vietnam",
                "Googol Jersey",
                "Googol Ethiopia",
        };
        savingTheUniverse.queries = new String[]{
                "Googol Jersey",
                "Googol Vietnam",
                "Googol Jersey",
                "Googol Jersey",
                "Googol Jersey",
                "Googol Jersey",
                "Googol Ethiopia",
                "Googol Ethiopia",
                "Googol Ethiopia",
                "Googol Ethiopia",
                "Googol Vietnam",
                "Googol Ethiopia",
        };
        assertThat(savingTheUniverse.getOutput(), is("1"));
    }

    @Test
    public void testcase5() throws Exception {
        SavingTheUniverse savingTheUniverse = new SavingTheUniverse();
        savingTheUniverse.searchEngines = new String[]{
                "Yeehaw Search",
                "Googol British Virgin Islands",
                "Googol Bahrain",
        };
        savingTheUniverse.queries = new String[]{
                "Googol British Virgin Islands",
                "Yeehaw Search",
                "Googol British Virgin Islands",
                "Googol British Virgin Islands",
                "Googol British Virgin Islands",
                "Googol British Virgin Islands",
                "Googol Bahrain",
                "Googol Bahrain",
                "Googol Bahrain",
                "Googol Bahrain",
                "Yeehaw Search",
                "Googol Bahrain",
                "Googol British Virgin Islands",
                "Yeehaw Search",
                "Googol British Virgin Islands",
                "Yeehaw Search",
                "Googol Bahrain",
                "Googol Bahrain",
                "Googol Bahrain",
        };
        assertThat(savingTheUniverse.getOutput(), is("3"));
    }

    @Test
    public void testcase6() throws Exception {
        SavingTheUniverse savingTheUniverse = new SavingTheUniverse();
        savingTheUniverse.searchEngines = new String[]{
                "Gurujh",
                "Googol New Zealand",
                "Googol Ecuador",
        };
        savingTheUniverse.queries = new String[]{
                "Googol New Zealand",
                "Gurujh",
                "Googol New Zealand",
                "Gurujh",
                "Googol Ecuador",
                "Googol Ecuador",
                "Googol Ecuador",
                "Googol New Zealand",
                "Gurujh",
                "Googol New Zealand",
                "Googol New Zealand",
                "Googol New Zealand",
                "Googol New Zealand",
                "Googol Ecuador",
                "Googol Ecuador",
                "Googol Ecuador",
                "Googol Ecuador",
                "Gurujh",
                "Googol Ecuador",
        };
        assertThat(savingTheUniverse.getOutput(), is("3"));
    }
}
