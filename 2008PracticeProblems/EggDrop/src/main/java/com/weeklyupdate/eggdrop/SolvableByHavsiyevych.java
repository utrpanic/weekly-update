package com.weeklyupdate.eggdrop;

public class SolvableByHavsiyevych extends Solvable {
    private long[][] matrix;

    SolvableByHavsiyevych(long floor, int eggs, int breaks) {
        super(floor, eggs, breaks);
    }

    SolvableByHavsiyevych(String[] params) {
        super(params);
    }

    @Override
    public void initializeMaxFloorMap() {
        matrix = new long[100000][MAX];
        for (int i = 1; i < 100000; i++) {
            for (int j = 1; j < MAX; j++) {
                if (j == 1) {
                    matrix[i][j] = i;
                } else if (i == j) {
                    matrix[i][j] = (long) Math.pow(2, j) - 1;
                } else if (j > i) {
                    matrix[i][j] = matrix[i][i];
                } else if (i > j) {
                    if (matrix[i-1][j] == -1 || matrix[i-1][j-1] == -1) {
                        matrix[i][j] = -1;
                    } else {
                        matrix[i][j] = matrix[i - 1][j] + matrix[i - 1][j - 1] + 1;
                        if (matrix[i][j] > 4294967296L) {
                            matrix[i][j] = -1;
                        }
                    }

                }
            }
        }
    }

    @Override
    public long getMaxFloorByMatrix(int eggs, int breaks) {
        if (breaks >= MAX) {
            breaks = MAX - 1;
        }
        if (breaks == 1) {
            return eggs;
        }

        if (eggs > 100000) {
            return -1;
        }

        return matrix[eggs][breaks];
    }

}
