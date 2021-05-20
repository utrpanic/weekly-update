package com.weeklyupdate.alwaysturnleft;

import java.io.*;
import java.util.HashMap;

public class AlwaysTurnLeft {

    private static final int LEFT_DIRECTION = 0;
    private static final int UP_DIRECTION = 1;
    private static final int RIGHT_DIRECTION = 2;
    private static final int DOWN_DIRECTION = 3;

    private static final char LEFT = 'L';
    private static final char RIGHT = 'R';
    private static final char WALK = 'W';

    private int minX = 0;
    private int maxY = 0;

    private HashMap<Key, Maze> mazes;

    public void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = null;
        BufferedWriter out = null;
        in = new BufferedReader(new FileReader(inputFileName));
        out = new BufferedWriter(new FileWriter(outputFileName));

        // 1. 셀 하나를 표현하는 객체를 만들고,
        // 2. 객체는 Quad-Directional Linked List로 정의. 한국말로 뭐인지도 모르겠네.
        // 3. entrance to exit path를 따라가면서 linked list 생성
        // 4. exit to entrance path를 따라가면서 linked list 계속 생성
        // 5. linked list가 완성되면, 출력.
        // 6. Entrance에서 왼쪽으로 쭉 가면 첫 값이 나오겠지.

        int numberOfCase = Integer.valueOf(in.readLine());
        for (int i = 0; i < numberOfCase; i++) {
            Maze currentMaze = init();
            String[] path = in.readLine().split(" ");
            System.out.println("Case " + (i + 1) + ": " + path[0] + ", " + path[1]);
            int currentDirection = DOWN_DIRECTION;
            for (int j = 0; j < path[0].length(); j++) {
                char a = path[0].charAt(j);
                if (a == WALK) {
                    currentMaze = walk(currentMaze, currentDirection);
                } else {
                    currentDirection = turn(currentDirection, a);
                }
            }

            mazes.remove(currentMaze.key);
            if (currentDirection == LEFT_DIRECTION && minX < 0) {
                minX++;
            }
            if (currentDirection == DOWN_DIRECTION) {
                maxY--;
            }

            currentDirection = reverseDirection(currentDirection);
            for (int k = 0; k < path[1].length(); k++) {
                char a = path[1].charAt(k);
                if (a == WALK) {
                    currentMaze = walk(currentMaze, currentDirection);
                } else {
                    currentDirection = turn(currentDirection, a);
                }
            }

            mazes.remove(currentMaze.key);

            System.out.println("Case #" + (i + 1) + ":");
            out.write("Case #" + (i + 1) + ":\n");
            for (int y = 0; y <= maxY; y++) {
                int x = minX;
                Maze maze;
                StringBuilder row = new StringBuilder();
                while ((maze = mazes.get(new Key(x, y))) != null) {
                    row.append(maze.getCharacter());
                    x++;
                }
                System.out.println(row.toString());
                out.write(row.toString() + "\n");
            }

        }

        in.close();
        out.close();
    }

    private Maze init() {
        Maze currentMaze = new Maze(0, -1);
        mazes = new HashMap<Key, Maze>();
        minX = 0;
        maxY = 0;
        return currentMaze;
    }

    private int reverseDirection(int currentDirection) {
        currentDirection -= 2;
        if (currentDirection < 0) {
            currentDirection += 4;
        }
        return currentDirection;
    }

    private Maze walk(Maze currentMaze, int currentDirection) {
        // create maze if null.
        switch (currentDirection) {
            case LEFT_DIRECTION:
                if (currentMaze.left == null) {
                    currentMaze.left = new Maze(currentMaze.key.x - 1, currentMaze.key.y);
                    mazes.put(currentMaze.left.key, currentMaze.left);
                }
                currentMaze.left.right = currentMaze;
                currentMaze = currentMaze.left;
                break;
            case UP_DIRECTION:
                if (currentMaze.up == null) {
                    currentMaze.up = new Maze(currentMaze.key.x, currentMaze.key.y - 1);
                    mazes.put(currentMaze.up.key, currentMaze.up);
                }
                currentMaze.up.down = currentMaze;
                currentMaze = currentMaze.up;
                break;
            case RIGHT_DIRECTION:
                if (currentMaze.right == null) {
                    currentMaze.right = new Maze(currentMaze.key.x + 1, currentMaze.key.y);
                    mazes.put(currentMaze.right.key, currentMaze.right);
                }
                currentMaze.right.left = currentMaze;
                currentMaze = currentMaze.right;
                break;
            case DOWN_DIRECTION:
                if (currentMaze.down == null) {
                    currentMaze.down = new Maze(currentMaze.key.x, currentMaze.key.y + 1);
                    mazes.put(currentMaze.down.key, currentMaze.down);
                }
                currentMaze.down.up = currentMaze;
                currentMaze = currentMaze.down;
                break;
        }

        if (currentMaze.key.x < minX) {
            minX = currentMaze.key.x;
        }
        if (currentMaze.key.y > maxY) {
            maxY = currentMaze.key.y;
        }
        return currentMaze;
    }

    private int turn(int currentDirection, char a) {
        // turn direction.
        if (a == RIGHT) {
            currentDirection++;
        } else if (a == LEFT) {
            currentDirection--;
        }

        if (currentDirection < 0) {
            currentDirection = DOWN_DIRECTION;
        } else if (currentDirection > DOWN_DIRECTION) {
            currentDirection = LEFT_DIRECTION;
        }
        return currentDirection;
    }

    class Maze {
        final int CAN_WORK_NORTH = 0x1;
        final int CAN_WORK_SOUTH = 0x2;
        final int CAN_WORK_WEST = 0x4;
        final int CAN_WORK_EAST = 0x8;
        Key key;

        Maze left;
        Maze up;
        Maze right;
        Maze down;

        Maze(int x, int y) {
            key = new Key(x, y);
        }

        public String getCharacter() {
            int character = 0;
            if (left != null) {
                character |= CAN_WORK_WEST;
            }
            if (up != null) {
                character |= CAN_WORK_NORTH;
            }
            if (right != null) {
                character |= CAN_WORK_EAST;
            }
            if (down != null) {
                character |= CAN_WORK_SOUTH;
            }

            return Integer.toHexString(character);
        }
    }

    class Key {
        int x;
        int y;

        Key (int x, int y) {
            this.x = x;
            this.y = y;
        }

        @Override
        public boolean equals(Object o) {
            Key toCompare = (Key) o;
            return x == toCompare.x && y == toCompare.y;
        }

        @Override
        public int hashCode() {
            return x * y;
        }
    }

    public static void main(String[] args) {
        AlwaysTurnLeft alwaysTurnLeft = new AlwaysTurnLeft();
        try {
            alwaysTurnLeft.process("AlwaysTurnLeft/B-small-practice.in", "AlwaysTurnLeft/B-small_practice.out");
            alwaysTurnLeft.process("AlwaysTurnLeft/B-large-practice.in", "AlwaysTurnLeft/B-large_practice.out");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
