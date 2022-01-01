package com.boxjeon.lasermaze;

import java.io.*;

public class LaserMaze {

    public static String PROJECT_ROOT = "qualification-round/";

    public static void main(String[] args) throws IOException {
        LaserMaze.process("laser_maze_example_input.txt", "laser_maze_example_output.txt");
        LaserMaze.process("laser_maze_input.txt", "laser_maze_output.txt");
    }

    public static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(PROJECT_ROOT + inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(PROJECT_ROOT + outputFileName));
        int numberOfCase = Integer.valueOf(in.readLine());
        for (int i = 0; i < numberOfCase; i++) {
            LaserMaze laserMaze = new LaserMaze();
            String output = "Case #" + (i + 1) + ": " + laserMaze.getOutput() + "\n";
            out.write(output);
            System.out.print(output);
        }
        in.close();
        out.close();
    }

    public String getOutput() {
        return "output";
    }

}
