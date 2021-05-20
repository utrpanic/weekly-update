package com.weeklyupdate.randomroute;

import junit.framework.TestCase;
import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class RandomRouteTest extends TestCase{

    @Test
    public void testcase1() throws Exception {
        RandomRoute randomRoute = new RandomRoute();
        randomRoute.setStartCityAndNumberOfRoads("5 san_francisco");
        randomRoute.setRoad("san_francisco los_angeles 6");
        randomRoute.setRoad("los_angeles san_diego 2");
        randomRoute.setRoad("san_francisco san_diego 8");
        randomRoute.setRoad("los_angeles san_diego 2");
        randomRoute.setRoad("san_francisco los_angeles 6");

        assertThat(randomRoute.getOutput(), is("0.4500000 0.2000000 0.1000000 0.2000000 0.4500000"));

    }
}
