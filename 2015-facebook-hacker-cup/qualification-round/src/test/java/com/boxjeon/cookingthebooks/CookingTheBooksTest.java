package com.boxjeon.cookingthebooks;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class CookingTheBooksTest {

    @Test
    public void testcase1() throws Exception {
        CookingTheBooks cookingTheBooks = new CookingTheBooks();

        assertThat(cookingTheBooks.getOutput("9990999"), is("9099999 9999990"));
    }

}
