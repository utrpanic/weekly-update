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
}
