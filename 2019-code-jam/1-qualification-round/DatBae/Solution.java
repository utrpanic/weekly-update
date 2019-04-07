package dev.utrpanic;

import java.util.*;
import java.io.*;

public class Solution {

    public static void main(String[] args) {
        Scanner in = new Scanner(new BufferedReader(new InputStreamReader(System.in)));
        int count = in.nextInt(); // Scanner has functions to read ints, longs, strings, chars, etc.
        for (int i = 1; i <= count; ++i) {
            int worked = in.nextInt();
            int broken = in.nextInt();
            int chance = in.nextInt();
            Database database = new Database(worked, broken, chance);
            boolean finished = false;
            while (!finished) {
                System.out.println(database.estimate());
                System.out.flush();
                String result = in.next();
                finished = database.handleResult(result);
            }
        }
    }
}

class Database {

    int worked;
    int broken;
    int chance;

    Database(int worked, int broken, int chance) {
        super();
        this.worked = worked;
        this.broken = broken;
        this.chance = chance;
    }

    String estimate() {
        return "1 2 3";
    }

    boolean handleResult(String result) {
        if (result.equals("1") || result.equals("-1")) {
            return true;
        } else {
            this.improveEstimation(result);
            return false;
        }
    }

    private void improveEstimation(String result) {

    }
}
