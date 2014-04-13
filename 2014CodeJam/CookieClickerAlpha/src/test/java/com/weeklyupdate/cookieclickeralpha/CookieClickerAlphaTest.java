package com.weeklyupdate.cookieclickeralpha;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class CookieClickerAlphaTest {

    @Test
    public void testcase1() throws Exception {
        CookieClickerAlpha cookieClickerAlpha = new CookieClickerAlpha();
        cookieClickerAlpha.init("30.0 1.0 2.0");

        assertThat(cookieClickerAlpha.getOutput(), is("1.0000000"));
    }

    @Test
    public void testcase2() throws Exception {
        CookieClickerAlpha cookieClickerAlpha = new CookieClickerAlpha();
        cookieClickerAlpha.init("30.0 2.0 100.0");

        assertThat(cookieClickerAlpha.getOutput(), is("39.1666667"));
    }

    @Test
    public void testcase3() throws Exception {
        CookieClickerAlpha cookieClickerAlpha = new CookieClickerAlpha();
        cookieClickerAlpha.init("30.50000 3.14159 1999.19990");

        assertThat(cookieClickerAlpha.getOutput(), is("63.9680013"));
    }

    @Test
    public void testcase4() throws Exception {
        CookieClickerAlpha cookieClickerAlpha = new CookieClickerAlpha();
        cookieClickerAlpha.init("500.0 4.0 2000.0");

        assertThat(cookieClickerAlpha.getOutput(), is("526.1904762"));
    }


}
