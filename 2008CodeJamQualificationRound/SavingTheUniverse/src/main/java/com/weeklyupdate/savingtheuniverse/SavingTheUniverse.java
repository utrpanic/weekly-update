package com.weeklyupdate.savingtheuniverse;

import java.io.*;
import java.util.*;

public class SavingTheUniverse {

    String[] searchEngines;
    String[] queries;
    String currentSearchEngine;

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
        currentSearchEngine = null;
    }

    String getOutput() {
        return getOutputByLongestJourney();
    }

    String getOutputByLongestJourney() {
        if (searchEngines.length == 0 || queries.length == 0) {
            return "0";
        }
        int numberOfSwitch = 0;
        chooseSearchEngineByLongestJourney(0);
        for (int i = 0; i < queries.length; i++) {
            if (shouldSwitchSearchEngine(i)) {
                chooseSearchEngineByLongestJourney(i);
                numberOfSwitch++;
            }
        }
        return String.valueOf(numberOfSwitch);
    }

    void chooseSearchEngineByLongestJourney(int startIndex) {
        List<String> notInQueries = new ArrayList<String>(Arrays.asList(searchEngines));
        for (int i = startIndex; i < queries.length; i++) {
            notInQueries.remove(queries[i]);
            if (notInQueries.size() == 0) {
                currentSearchEngine = queries[i];
                break;
            }
        }
        if (notInQueries.size() != 0) {
            currentSearchEngine = notInQueries.get(0);
        }
    }

    boolean shouldSwitchSearchEngine(int i) {
        return queries[i].equals(currentSearchEngine);
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
