package com.boxjeon.cookingthebooks;

import java.io.*;

public class CookingTheBooks {

    public static String PROJECT_ROOT = "qualification-round/";

    public static void main(String[] args) throws IOException {
        CookingTheBooks.process("cooking_the_books_example_input.txt", "cooking_the_books_example_output.txt");
        CookingTheBooks.process("cooking_the_books_input.txt", "cooking_the_books_output.txt");
    }

    public static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(PROJECT_ROOT + inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(PROJECT_ROOT + outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        CookingTheBooks cookingTheBooks = new CookingTheBooks();
        for (int i = 0; i < numberOfCase; i++) {
            String originalNumber = in.readLine();
            String output = "Case #" + (i + 1) + ": " + cookingTheBooks.getOutput(originalNumber) + "\n";
            out.write(output);
            System.out.print(output + "\n");
        }

        in.close();
        out.close();
    }

    public String getSmallestNumber(String number, boolean swapZero) {
        if (number.length() == 1) {
            return number;
        }
        int smallestDigitIndex = 0;
        int smallestDigit = Integer.parseInt(number.charAt(0) + "");
        for (int i = 1; i < number.length(); i++) {
            int digit = Integer.parseInt(number.charAt(i) + "");
            if (digit <= smallestDigit) {
                if (swapZero || digit != 0) {
                    smallestDigitIndex = i;
                    smallestDigit = digit;
                }
            }
        }

        if (smallestDigitIndex == 0) {
            return number.charAt(0) + getSmallestNumber(number.substring(1), true);
        } else {
            char[] charArray = number.toCharArray();
            char temp = charArray[0];
            charArray[0] = charArray[smallestDigitIndex];
            charArray[smallestDigitIndex] = temp;
            return new String(charArray);
        }
    }

    public String getLargestNumber(String number) {
        if (number.length() == 1) {
            return number;
        }

        int largestDigitIndex = 0;
        int largestDigit = Integer.parseInt(number.charAt(0) + "");
        for (int i = 1; i < number.length(); i++) {
            int digit = Integer.parseInt(number.charAt(i) + "");
            if (digit > largestDigit) {
                largestDigitIndex = i;
                largestDigit = digit;
            }
        }

        if (largestDigitIndex == 0) {
            return number.charAt(0) + getLargestNumber(number.substring(1));
        } else {
            char[] charArray = number.toCharArray();
            char temp = charArray[0];
            charArray[0] = charArray[largestDigitIndex];
            charArray[largestDigitIndex] = temp;
            return new String(charArray);
        }
    }

    public String getOutput(String originalNumber) {
        return getSmallestNumber(originalNumber, false) + " " + getLargestNumber(originalNumber);
    }

}
