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

class Position {

    int row;
    int column;

    Position(int row, int column) {
        super();
        this.row = row;
        this.column = column;
    }

    boolean isDone() {
        return this.row == 0 && this.column == 0;
    }

    boolean isFailed() {
        return this.row == -1 && this.column == -1;
    }

    void toZeroBase() {
        this.row--;
        this.column--;
    }

    void toOneBase() {
        this.row++;
        this.column++;
    }

    @Override
    public String toString() {
        return "" + this.row + " " + this.column;
    }
}

class GoGopher {

    int numberOfCellNeeded;
    boolean[][] cells;

    int currentColumn = 1;

    GoGopher(int numberOfCellNeeded) {
        super();
        this.numberOfCellNeeded = numberOfCellNeeded;
        int row = 3;
        int column = (numberOfCellNeeded / row) + (numberOfCellNeeded % row == 0 ? 0 : 1);
        column = Math.max(3, column);
        this.cells = new boolean[row][column];
    }

    Position targetCellOrigin() {
        this.updateCurrentPosition();
        Position target = new Position(1, this.currentColumn);
        target.toOneBase();
        return target;
    }

    void updateCurrentPosition() {
        int maxColumnIndex = this.cells[0].length - 2;
        for (int i = this.currentColumn - 1; i < this.cells[0].length - 1; i++) {
            if (this.cells[0][i] && this.cells[1][i] && this.cells[2][i]) {
                // do nothing.
            } else {
                this.currentColumn = Math.min(i + 1, maxColumnIndex);
                return;
            }
        }
        this.currentColumn = maxColumnIndex;
    }

    void prepareCell(Position preparedPosition) {
        preparedPosition.toZeroBase();
        this.cells[preparedPosition.row][preparedPosition.column] = true;
    }
}
