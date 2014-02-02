package com.weeklyupdate.eggdrop;

public class Solvable {
    long floor;
    int eggs;
    int breaks;
    final static int MAX = 33;
    static long[][] maxFloors = null;

    Solvable(long floor, int eggs, int breaks) {
        this.floor = floor;
        this.eggs = eggs;
        this.breaks = breaks;
    }

    Solvable(String[] params) {
        floor = Long.parseLong(params[0]);
        eggs = Integer.parseInt(params[1]);
        breaks = Integer.parseInt(params[2]);
    }

    @Override
    public String toString() {
        return floor + " " + eggs + " " + breaks;
    }

    public static void initializeMaxFloorMap() {
        if (maxFloors == null) {
            maxFloors = new long[MAX][MAX];
            StringBuilder sb;
            for (int i = 1; i < MAX; i++) {
                sb = new StringBuilder();
                for (int j = 1; j < MAX; j++) {
                    if (j > i + 1) {
                        maxFloors[i][j] = 0;
                    } else if (i == 1 || j == 1) {
                        maxFloors[i][j] = 1;
                    } else if (i == j) {
                        maxFloors[i][j] = i;
                    } else {
                        maxFloors[i][j] = maxFloors[i - 1][j] + maxFloors[i - 1][j - 1];
                    }
                    sb.append(maxFloors[i][j]).append(" ");
                }
                //System.out.println(sb.toString());
            }
        }
    }

    public static long getMaxFloorByMatrix(int eggs, int breaks) {
        long max = 0;
        if (breaks == 1) {
            max = eggs;
        } else if (breaks >= eggs) {
            max = (long) (Math.pow(2, eggs) - 1);
        } else if (breaks >= MAX) {
            max = -1;
        } else {
            for (int i = breaks; i > 0; i--) {
                long innerMax = getMaxFloorByMatrix(eggs - breaks + 1, i);
                if (innerMax == -1) {
                    return -1;
                }
                max += innerMax * maxFloors[breaks - 1][i];
                if (max >= 4294967296L) {
                    return -1;
                }
            }
            max += Math.pow(2, breaks - 1) - 1;
            if (max >= 4294967296L) {
                max = -1;
            }
        }
        return max;
    }

    public static int getMinEggsByRecursion(long floor, int eggs, int breaks) {
        for (int i = 1; i <= eggs; i++) {
            long maxFloor = getMaxFloorByMatrix(i, breaks);
            //System.out.println("getMinEggsByRecursion() eggs: " + i + ", breaks: " + breaks);
            if (maxFloor < 0 || maxFloor >= floor) {
                return i;
            }
        }
        return -1;
    }

    public static int getMinBreaksByRecursion(long floor, int eggs, int breaks) {
        if (eggs >= floor) {
            return 1;
        }
        for (int i = 1; i <= breaks; i++) {
            long maxFloor = getMaxFloorByMatrix(eggs, i);
            //System.out.println("getMinBreaksByRecursion() eggs: " + eggs + ", breaks: " + i);
            if (maxFloor < 0 || maxFloor >= floor) {
                return i;
            }
        }
        return -1;
    }

}
