import java.util.*;
import java.io.*;

public class Solution{

    public static void main(String[] args) {
        Scanner in = new Scanner(new BufferedReader(new InputStreamReader(System.in)));
        int t = Integer.parseInt(in.nextLine());
        for (int i = 1; i <= t; ++i) {
            int numberOfCellNeeded = in.nextInt();
            GoGopher goGopher = new GoGopher(numberOfCellNeeded);
            Position target;
            do {
                target = goGopher.targetCellOrigin();
                System.out.println(target);
                target.row = in.nextInt();
                target.column = in.nextInt();
                if (target.isDone()) {
                    break;
                } else if (target.isFailed()) {
                    System.exit(0);
                } else {
                    goGopher.prepareCell(target);
                }
            } while(true);
        }
    }
}
