package com.weeklyupdate.eggdrop;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class EggDropTest {

    EggDrop eggDrop;

    @Before
    public void setUp() throws Exception {
        eggDrop = new EggDrop();
    }

//    @Test
//    public void testSolvable1() throws Exception {
//        Solvable result = eggDrop.solvable(new Solvable(3, 3, 3));
//        assertThat(result.toString(), is("7 2 1"));
//    }
//
//    @Test
//    public void testSolvable2() throws Exception {
//        Solvable result = eggDrop.solvable(new Solvable(7, 5, 3));
//        assertThat(result.toString(), is("25 3 2"));
//    }
//
//    @Test
//    public void testSolvable3() throws Exception {
//        Solvable result = eggDrop.solvable(new Solvable(2, 2, 1));
//        assertThat(result.toString(), is("2 2 1"));
//    }
//
//    @Test
//    public void testSolvable4() throws Exception {
//        Solvable result = eggDrop.solvable(new Solvable(3, 6, 1));
//        assertThat(result.toString(), is("6 3 1"));
//    }
//
//    @Test
//    public void testSolvable5() throws Exception {
//        Solvable result = eggDrop.solvable(new Solvable(6, 3, 2));
//        assertThat(result.toString(), is("6 3 2"));
//    }

//    @Test
//    public void testSolvable6() throws Exception {
//        int minEggs = Solvable.getMinEggsByRecursion(4294967296L, Integer.MAX_VALUE, Integer.MAX_VALUE);
//        assertThat(minEggs, is(0));
//    }


    @Test
    public void testSolcable7() throws Exception {
                Solvable result = eggDrop.solvable(new Solvable(1312683601, 37906895, 2316650));
        assertThat(result.toString(), is("6 3 2"));
    }
}
