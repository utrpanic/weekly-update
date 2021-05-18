import java.io.*;
import java.util.ArrayList;

public class Solution {

    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(
            new StringReader(
                "3\n" +
                TestCase.testCase1.input +
                TestCase.testCase2.input +
                TestCase.testCase3.input 
            )
        );
        // BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int numberOfCase = Integer.valueOf(reader.readLine());
        for (int i = 0; i < numberOfCase; i++) {
            MagicTrick magicTrick = new MagicTrick(reader);
            System.out.println("Case #" + (i + 1) + ": " + magicTrick.getOutput());
        }
    }
}

class MagicTrick {

    int rowAtFirstDeck;
    int rowAtSecondDeck;

    int[][] firstDeck = new int[4][4];
    int[][] secondDeck = new int[4][4];

    MagicTrick(BufferedReader reader) throws IOException {
        rowAtFirstDeck = Integer.parseInt(reader.readLine()) - 1;
        for (int row = 0; row < 4; row++) {
            String[] record = reader.readLine().split(" ");
            for (int i = 0; i < 4; i++) {
                firstDeck[row][i] = Integer.parseInt(record[i]);
            }
        }
        rowAtSecondDeck = Integer.parseInt(reader.readLine()) - 1;
        for (int row = 0; row < 4; row++) {
            String[] record = reader.readLine().split(" ");
            for (int i = 0; i < 4; i++) {
                secondDeck[row][i] = Integer.parseInt(record[i]);
            }
        }
    }

    String getOutput() {
        ArrayList<Integer> matchedCards = new ArrayList<Integer>();
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                if (firstDeck[rowAtFirstDeck][i] == secondDeck[rowAtSecondDeck][j]) {
                    matchedCards.add(firstDeck[rowAtFirstDeck][i]);
                }
            }
        }

        if (matchedCards.size() > 1) {
            return "Bad magician!";
        } else if (matchedCards.size() == 0) {
            return "Volunteer cheated!";
        } else {
            return matchedCards.get(0).toString();
        }
    }
}

class TestCase {

    String input;

    TestCase(String input) {
        this.input = input;
    }

    static TestCase testCase1 = new TestCase(
        "2\n" + 
        "1 2 3 4\n" + 
        "5 6 7 8\n" + 
        "9 10 11 12\n" + 
        "13 14 15 16\n" + 
        "3\n" + 
        "1 2 5 4\n" + 
        "3 11 6 15\n" + 
        "9 10 7 12\n" + 
        "13 14 8 16\n"
    ); // 7

    static TestCase testCase2 = new TestCase(
        "2\n" + 
        "1 2 3 4\n" + 
        "5 6 7 8\n" + 
        "9 10 11 12\n" + 
        "13 14 15 16\n" + 
        "2\n" + 
        "1 2 3 4\n" + 
        "5 6 7 8\n" + 
        "9 10 11 12\n" + 
        "13 14 15 16\n"
    ); // Bad magician!

    static TestCase testCase3 = new TestCase(
        "2\n" + 
        "1 2 3 4\n" + 
        "5 6 7 8\n" + 
        "9 10 11 12\n" + 
        "13 14 15 16\n" + 
        "3\n" + 
        "1 2 3 4\n" + 
        "5 6 7 8\n" + 
        "9 10 11 12\n" + 
        "13 14 15 16\n" 
    ); // Volunteer cheated!
}