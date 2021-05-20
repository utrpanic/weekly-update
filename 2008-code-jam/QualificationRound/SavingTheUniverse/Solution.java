import java.io.*;
import java.util.*;

public class Solution {

    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(
            new StringReader(
                "5\n" +
                TestCase.testCase1.string() +
                TestCase.testCase2.string() +
                TestCase.testCase3.string() +
                TestCase.testCase4.string() +
                TestCase.testCase5.string()
            )
        );
        // BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int numberOfCase = Integer.valueOf(reader.readLine());
        for (int i = 0; i < numberOfCase; i++) {
            SavingTheUniverse savingTheUniverse = new SavingTheUniverse(reader);
            System.out.println("Case #" + (i + 1) + ": " + savingTheUniverse.getOutput());
        }
    }
}

class SavingTheUniverse {

    String[] searchEngines;
    String[] queries;
    String currentSearchEngine;

    SavingTheUniverse(BufferedReader input) throws IOException {
        int numberOfSearchEngines = Integer.valueOf(input.readLine());
        searchEngines = new String[numberOfSearchEngines];
        for (int i = 0; i < numberOfSearchEngines; i++) {
            searchEngines[i] = input.readLine();
        }
        int numberOfQueries = Integer.valueOf(input.readLine());
        queries = new String[numberOfQueries];
        for (int i = 0; i < numberOfQueries; i++) {
            queries[i] = input.readLine();
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
}

class TestCase {

    String[] engines;
    String[] queries;
    
    TestCase(String[] engines, String[] queries) {
        this.engines = engines;
        this.queries = queries;
    }

    String string() {
        var result = "";
        result += this.engines.length + "\n";
        for (int i = 0; i < this.engines.length; i++) {
            result += this.engines[i] + "\n";
        }
        result += this.queries.length + "\n";
        for (int i = 0; i < this.queries.length; i++) {
            result += this.queries[i] + "\n";
        }
        return result;
    }

    static TestCase testCase1 = new TestCase(new String[] {
        "Yeehaw",
        "NSM",
        "Dont Ask",
        "B9",
        "Googol",
    }, new String[] {
        "Yeehaw",
        "Yeehaw",
        "Googol",
        "B9",
        "Googol",
        "NSM",
        "B9",
        "NSM",
        "Dont Ask",
        "Googol",
    }); // 1

    static TestCase testCase2 = new TestCase(new String[] {
        "Yeehaw",
        "NSM",
        "Dont Ask",
        "B9",
        "Googol",
    }, new String[] {
        "Googol",
        "Dont Ask",
        "NSM",
        "NSM",
        "Yeehaw",
        "Yeehaw",
        "Googol",
    }); // 0

    static TestCase testCase3 = new TestCase(new String[] {
        "Googol Vietnam",
        "Googol Jersey",
        "Googol Ethiopia",
    }, new String[] {
        "Googol Jersey",
        "Googol Vietnam",
        "Googol Jersey",
        "Googol Jersey",
        "Googol Jersey",
        "Googol Jersey",
        "Googol Ethiopia",
        "Googol Ethiopia",
        "Googol Ethiopia",
        "Googol Ethiopia",
        "Googol Vietnam",
        "Googol Ethiopia",
    }); // 1

    static TestCase testCase4 = new TestCase(new String[] {
        "Yeehaw Search",
        "Googol British Virgin Islands",
        "Googol Bahrain",
    }, new String[] {
        "Googol British Virgin Islands",
        "Yeehaw Search",
        "Googol British Virgin Islands",
        "Googol British Virgin Islands",
        "Googol British Virgin Islands",
        "Googol British Virgin Islands",
        "Googol Bahrain",
        "Googol Bahrain",
        "Googol Bahrain",
        "Googol Bahrain",
        "Yeehaw Search",
        "Googol Bahrain",
        "Googol British Virgin Islands",
        "Yeehaw Search",
        "Googol British Virgin Islands",
        "Yeehaw Search",
        "Googol Bahrain",
        "Googol Bahrain",
        "Googol Bahrain",
    }); // 3
    
    static TestCase testCase5 = new TestCase(new String[] {
        "Gurujh",
        "Googol New Zealand",
        "Googol Ecuador",
    }, new String[] {
        "Googol New Zealand",
        "Gurujh",
        "Googol New Zealand",
        "Gurujh",
        "Googol Ecuador",
        "Googol Ecuador",
        "Googol Ecuador",
        "Googol New Zealand",
        "Gurujh",
        "Googol New Zealand",
        "Googol New Zealand",
        "Googol New Zealand",
        "Googol New Zealand",
        "Googol Ecuador",
        "Googol Ecuador",
        "Googol Ecuador",
        "Googol Ecuador",
        "Gurujh",
        "Googol Ecuador",
    }); // 3
}
