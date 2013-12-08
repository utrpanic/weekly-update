package com.weeklyupdate.aliennumbers;

import java.io.*;

public class AlienNumbers {
    public static void main(String[] args) throws IOException {
        // file input
        BufferedReader in = null;
        BufferedWriter out = null;
        try {
            in = new BufferedReader(new FileReader("AlienNumbers/A-small-practice.in"));
            out = new BufferedWriter(new FileWriter("AlienNumbers/A-small-practice.out"));
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

            out.write("Case #" + (i + 1) + ": " + targetString + "\n");
        }
        in.close();
        out.close();
    }

    private static String translate(String alienNumber, String sourceLanguage, String targetLanguage) {
        String njin = "";
        for (int i = 0; i < alienNumber.length(); i++) {
            char a = alienNumber.charAt(i);
            int n = sourceLanguage.indexOf(a);
            njin += n;
        }
        System.out.println(njin + ": " + Integer.parseInt(njin, sourceLanguage.length()));
        int decimalNumber = Integer.parseInt(njin, sourceLanguage.length());
        String targetNumber = Integer.toString(decimalNumber, targetLanguage.length());
        njin = "";
        for (int i = 0; i < targetNumber.length(); i++) {
            char a = targetNumber.charAt(i);
            int n = Integer.parseInt(String.valueOf(a));
            njin += targetLanguage.charAt(n);
        }
        return njin;
    }
}
