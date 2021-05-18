package com.weeklyupdate.eggdrop;

import java.io.*;

public class EggDrop {

    public Solvable solvable(Solvable solvable) {

        solvable.initializeMaxFloorMap();

        long maxFloor = solvable.getMaxFloorByMatrix(solvable.eggs, solvable.breaks);
        int minEggs = solvable.getMinEggsByRecursion(solvable.floor, solvable.eggs, solvable.breaks);
        int minBreak = solvable.getMinBreaksByRecursion(solvable.floor, solvable.eggs, solvable.breaks);
        Solvable newSolvable = new Solvable(maxFloor, minEggs, minBreak);
        System.out.println(solvable.toString() + " / " + newSolvable.toString());
        return newSolvable;
    }

    private void process(String inputFileName, String outputFileName) throws IOException {

        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        for (int i = 0; i < numberOfCase; i++) {
            String[] params = in.readLine().split(" ");
            Solvable output = solvable(new SolvableByHavsiyevych(params));
            out.write("Case #" + (i + 1) + ": " + output.toString() + "\n");
        }

        in.close();
        out.close();
    }

    public static void main(String[] args) throws IOException {
        EggDrop eggDrop = new EggDrop();

        eggDrop.process("EggDrop/C-small-practice.in", "EggDrop/C-small-practice.out");
        eggDrop.process("EggDrop/C-large-practice.in", "EggDrop/C-large-practice.out");
    }

}
