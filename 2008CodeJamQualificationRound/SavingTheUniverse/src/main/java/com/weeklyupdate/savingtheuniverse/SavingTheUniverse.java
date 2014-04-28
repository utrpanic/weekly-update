package com.weeklyupdate.savingtheuniverse;

import java.io.*;

public class SavingTheUniverse {

    String[] searchEngines;
    String[] queries;

    void initSearchEngines(BufferedReader in) throws IOException {
        int numberOfSearchEngines = Integer.valueOf(in.readLine());
        searchEngines = new String[numberOfSearchEngines];
        for (int i = 0; i < numberOfSearchEngines; i++) {
            searchEngines[i] = in.readLine();
        }
    }

    void initQuries(BufferedReader in) throws IOException {
        int numberOfQueries = Integer.valueOf(in.readLine());
        queries = new String[numberOfQueries];
        for (int i = 0; i < numberOfQueries; i++) {
            queries[i] = in.readLine();
        }
    }

    String getOutput() {
        return "1";
    }

    public static void main(String[] args) throws IOException {
        SavingTheUniverse.process("SavingTheUniverse/A-small-practice.in", "SavingTheUniverse/A-small-practice.out");
        SavingTheUniverse.process("SavingTheUniverse/A-large-practice.in", "SavingTheUniverse/A-large-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        SavingTheUniverse savingTheUniverse = new SavingTheUniverse();
        for (int i = 0; i < numberOfCase; i++) {
            savingTheUniverse.initSearchEngines(in);
            savingTheUniverse.initQuries(in);
            String output = "Case #" + (i + 1) + ": " + savingTheUniverse.getOutput() + "\n";
            out.write(output);
            System.out.print(output + "\n");
        }

        in.close();
        out.close();
    }
}
