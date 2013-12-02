package com.weeklyupdate.aliennumbers;

import java.io.*;

public class AlienNumbers {
    public static void main(String[] args) throws IOException {
        System.out.println("out");

        // file input
        BufferedReader in = null;
        BufferedWriter out = null;
        try {
            in = new BufferedReader(new FileReader("input/A-small-practice.in"));
            out = new BufferedWriter(new FileWriter("output/A-small-practice.out"));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        int testCaseCount = Integer.parseInt(in.readLine());
        String alienNumber, sourceLanguage, targetLanguage;
        String line;
        for (int i = 0; i < testCaseCount; i++) {
            line = in.readLine();
            String[] params = line.split(" ");
            alienNumber = params[0];
            sourceLanguage = params[1];
            targetLanguage = params[2];

            String targetString = translate(alienNumber, sourceLanguage, targetLanguage);

//            String outputLine = i + ": " + alienNumber + " " + sourceLanguage + "  " + targetLanguage + "\n";
//            System.out.println(outputLine);

            out.write("Case #" + (i+1) + ": " + targetString + "\n");
        }
        in.close();
        out.close();
    }

    private static String translate(String alienNumber, String sourceLanguage, String targetLanguage) {


        return null;
    }
}
