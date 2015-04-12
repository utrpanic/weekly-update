package com.boxjeon.standingovation;

import java.io.*;

public class StandingOvation {

    public static String PROJECT_ROOT = "qualification-round/";

    public static void main(String[] args) throws IOException {
        StandingOvation.process("standing_ovation_example_input.txt", "standing_ovation_example_output.txt");
        StandingOvation.process("standing_ovation_small.in", "standing_ovation_small.out");
        StandingOvation.process("standing_ovation_large.in", "standing_ovation_large.out");
    }

    public static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(PROJECT_ROOT + inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(PROJECT_ROOT + outputFileName));

        long totalTime = 0;

        int numberOfCase = Integer.valueOf(in.readLine());
        StandingOvation standingOvation = new StandingOvation();
        for (int i = 0; i < numberOfCase; i++) {
            long time = System.currentTimeMillis();

            standingOvation.init(in.readLine().split(" "));
            String output = "Case #" + (i + 1) + ": " + standingOvation.getOutput() + "\n";

            time = (System.currentTimeMillis() - time) / 1000;
            totalTime += time;
            System.out.println("Time: " + time + " sec");
            System.out.println(output);

            out.write(output);
        }

        System.out.println("Total time: " + totalTime + " sec");

        in.close();
        out.close();
    }

    int[] audiencesWithShyness;

    public void init(String[] args) {
        int maxShyness = Integer.parseInt(args[0]);
        this.audiencesWithShyness = new int[maxShyness + 1];
        for (int i = 0; i < this.audiencesWithShyness.length; i++) {
            this.audiencesWithShyness[i] = Integer.parseInt(String.valueOf(args[1].charAt(i)));
        }
    }

    public String getOutput() {
        int numberOfFriends = 0;
        int numberOfAudience = 0;
        for (int shyness = 0; shyness < this.audiencesWithShyness.length; shyness++) {
            if (numberOfAudience < shyness) {
                numberOfFriends += shyness - numberOfAudience;
                numberOfAudience = shyness;
            }
            numberOfAudience += this.audiencesWithShyness[shyness];
        }
        return String.valueOf(numberOfFriends);
    }
}
