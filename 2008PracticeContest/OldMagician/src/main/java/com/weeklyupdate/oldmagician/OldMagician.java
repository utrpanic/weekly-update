package com.weeklyupdate.oldmagician;

import java.io.*;

public class OldMagician {

    int numberOfWhite;
    int numberOfBlack;

    void init(String input) {
        String[] inputs = input.split(" ");
        numberOfWhite = Integer.parseInt(inputs[0]);
        numberOfBlack = Integer.parseInt(inputs[1]);
    }

    String getOutput() {
        if (numberOfBlack == 1) {
            return "BLACK";
        } else if (numberOfBlack == 6) {
            return "WHITE";
        } else {
            return "UNKNOWN";
        }
    }

    public static void main(String[] args) throws IOException {
        OldMagician.process("OldMagician/A-small-practice.in", "OldMagician/A-small-practice.out");
        OldMagician.process("OldMagician/A-large-practice.in", "OldMagician/A-large-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        OldMagician oldMagician = new OldMagician();
        for (int i = 0; i < numberOfCase; i++) {


            String output = "Case #" + (i + 1) + ": " + oldMagician.getOutput() + "\n";
            out.write(output);
            System.out.print(output + "\n");
        }

        in.close();
        out.close();
    }

}
