package com.weeklyupdate.aliennumbers;

import java.io.*;
import java.util.ArrayList;

public class AlienNumbers {
    private void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

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

            out.write("Case #" + (i + 1) + ": " + targetString + "\n");
        }
        in.close();
        out.close();
    }

    private String translate(String alienNumber, String sourceLanguage, String targetLanguage) {
        int sourceNumberBase = sourceLanguage.length();
        int targetNumberBase = targetLanguage.length();
        int[] numberInBase = new int[alienNumber.length()];
        for (int i = 0; i < alienNumber.length(); i++) {
            char a = alienNumber.charAt(i);
            int n = sourceLanguage.indexOf(a);
            numberInBase[i] = n;
        }

        int decimalNumber = parseToDecimalNumber(numberInBase, sourceNumberBase);
        int[] targetNumber = parseToBaseNumber(decimalNumber, targetNumberBase);

        String targetAlienNumber = "";
        for (int targetNumberAt : targetNumber) {
            targetAlienNumber += String.valueOf(targetLanguage.charAt(targetNumberAt));
        }
        return targetAlienNumber;
    }

    private int parseToDecimalNumber(int[] numberInBase, int sourceNumberBase) {
        int decimalNumber = 0;
        int sourceNumberBaseUnit = 1;
        for (int i = numberInBase.length - 1; i >= 0; i--) {
            decimalNumber += numberInBase[i] * sourceNumberBaseUnit;
            sourceNumberBaseUnit *= sourceNumberBase;
        }
        return decimalNumber;
    }

    private int[] parseToBaseNumber(int decimalNumber, int targetNumberBase) {
        ArrayList<Integer> list = new ArrayList<Integer>();
        while (decimalNumber != 0) {
            list.add(0, decimalNumber % targetNumberBase);
            decimalNumber /= targetNumberBase;
        }
        int[] result = new int[list.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = list.get(i);
        }
        return result;
    }

    public static void main(String[] args) throws IOException {
        AlienNumbers alienNumbers = new AlienNumbers();

        alienNumbers.process("AlienNumbers/A-small-practice.in", "AlienNumbers/A-small-practice.out");
        alienNumbers.process("AlienNumbers/A-large-practice.in", "AlienNumbers/A-large-practice.out");
    }
}
