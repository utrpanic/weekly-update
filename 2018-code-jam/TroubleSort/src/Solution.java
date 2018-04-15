import java.util.*;
import java.io.*;

public class Solution {

    public static void main(String[] args) {
        Reader reader = new StringReader(
                "2\n" +
                        "5\n" +
                        "5 6 8 4 3\n" +
                        "3\n" +
                        "8 9 7");
//        Reader reader = new BufferedReader(new InputStreamReader(System.in));
        Scanner in = new Scanner(reader);
        int t = Integer.parseInt(in.nextLine());
        for (int i = 1; i <= t; ++i) {
            int size = in.nextInt();
            int[] integers = new int[size];
            for (int j = 0; j < size; j++) {
                integers[j] = in.nextInt();
            }
            TroubleSort sort = new TroubleSort(integers);
            System.out.println("Case #" + i + ": " + sort.output());
        }
    }
}
