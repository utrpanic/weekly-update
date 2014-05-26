package com.weeklyupdate.flyswatter;

import java.io.*;

public class FlySwatter {





    public static void main(String[] args) throws IOException {
        FlySwatter.process("FlySwatter/C-small-practice.in", "FlySwatter/C-small-practice.out");
        FlySwatter.process("FlySwatter/C-large-practice.in", "FlySwatter/C-large-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        FlySwatter flySwatter = new FlySwatter();
        for (int i = 0; i < numberOfCase; i++) {
            flySwatter.init(in);
            String output = "Case #" + (i + 1) + ": " + flySwatter.getOutput() + "\n";
            out.write(output);
            System.out.print(output + "\n");
        }

        in.close();
        out.close();
    }

    private void init(BufferedReader in) {

    }

    private String getOutput() {
        return "";
    }
}
