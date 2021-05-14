import java.util.*;
import java.io.*;

public class Solution {

    public static void main(String[] args) {
        Reader reader = new StringReader(
                "6\n" +
                "1 CS\n" +
                "2 CS\n" +
                "1 SS\n" +
                "6 SCCSSC\n" +
                "2 CC\n" +
                "3 CSCSS");
//        Reader reader = new BufferedReader(new InputStreamReader(System.in));
        Scanner in = new Scanner(reader);
        int t = Integer.parseInt(in.nextLine());
        for (int i = 1; i <= t; ++i) {
            String input = in.nextLine();
            String[] split = input.split(" ");
            int shield = Integer.parseInt(split[0]);
            String instructions = split[1];
            President president = new President(shield, instructions);
            System.out.println("Case #" + i + ": " + president.output());
        }
    }
}
