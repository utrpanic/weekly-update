package com.boxjeon.newyearsresolution;

import java.io.*;

public class NewYearsResolution {

    public static String PROJECT_ROOT = "qualification-round/";

    class MacroNutrients {
        int protein;
        int carbohydrates;
        int fat;

        public MacroNutrients() {
            // do nothing.
        }

        public MacroNutrients(String[] inputArray) {
            this.protein = Integer.parseInt(inputArray[0]);
            this.carbohydrates = Integer.parseInt(inputArray[1]);
            this.fat = Integer.parseInt(inputArray[2]);
        }

        public MacroNutrients eat(MacroNutrients food) {
            MacroNutrients newTarget = new MacroNutrients();
            newTarget.protein = this.protein - food.protein;
            newTarget.carbohydrates = this.carbohydrates - food.carbohydrates;
            newTarget.fat = this.fat - food.fat;
            return newTarget;
        }

        public boolean isAvailable() {
            return this.protein >= 0 && this.carbohydrates >= 0 && this.fat >= 0;
        }

        public boolean isZero() {
            return this.protein == 0 && this.carbohydrates == 0 && this.fat == 0;
        }

        @Override
        public String toString() {
            return protein + ", " + carbohydrates + ", " + fat;
        }
    }

    MacroNutrients newYearsTarget;
    MacroNutrients[] foods;

    public static void main(String[] args) throws IOException {
        NewYearsResolution.process("new_years_resolution_example_input.txt", "new_years_resolution_example_output.txt");
        NewYearsResolution.process("new_years_resolution_input.txt", "new_years_resolution_output.txt");
    }

    public static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(PROJECT_ROOT + inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(PROJECT_ROOT + outputFileName));
        int numberOfCase = Integer.valueOf(in.readLine());
        for (int i = 0; i < numberOfCase; i++) {
            NewYearsResolution newYearsResolution = new NewYearsResolution();
            newYearsResolution.setTargetMacroNutrients(in.readLine());
            System.out.println("Target: " + newYearsResolution.newYearsTarget);
            int numberOfFood = Integer.parseInt(in.readLine());
            newYearsResolution.setNumberOfFood(numberOfFood);
            for (int j = 0; j < numberOfFood; j++) {
                newYearsResolution.setFood(j, in.readLine());
            }
            String output = "Case #" + (i + 1) + ": " + newYearsResolution.getOutput() + "\n";
            out.write(output);
            System.out.print(output);
        }
        in.close();
        out.close();
    }

    public void setTargetMacroNutrients(String input) {
        this.newYearsTarget = new MacroNutrients(input.split(" "));
    }

    public void setNumberOfFood(int numberOfFood) {
        this.foods = new MacroNutrients[numberOfFood];
    }

    public void setFood(int index, String input) {
        this.foods[index] = new MacroNutrients(input.split(" "));
    }

    public String getOutput() {
        for (int i = 0; i < foods.length; i++) {
            if (isBalanced(i, newYearsTarget)) {
                return "yes";
            }
        }
        return "no";
    }

    public boolean isBalanced(int index, MacroNutrients target) {
        MacroNutrients newTarget = target.eat(foods[index]);
        if (newTarget.isAvailable()) {
            if (newTarget.isZero()) {
                return true;
            } else {
                for (int i = index + 1; i < foods.length; i++) {
                    if (isBalanced(i, newTarget)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

}
