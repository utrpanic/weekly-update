package com.weeklyupdate.alwaysturnleft;

import java.io.*;

public class TurnLeft {

    public static void main(String[] args) {
        TurnLeft turnLeft = new TurnLeft();
        turnLeft.process("AlwaysTurnLeft/A-small-practice.in", "AlwaysTurnLeft/A-small_practice.out");
        turnLeft.process("AlwaysTurnLeft/A-large-practice.in", "AlwaysTurnLeft/A-large_practice.out");
    }

    public void process(String inputFileName, String outputFileName) {
        BufferedReader in = null;
        BufferedWriter out = null;
        try {
            in = new BufferedReader(new FileReader(inputFileName));
            out = new BufferedWriter(new FileWriter(outputFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 1. 셀 하나를 표현하는 객체를 만들고,
        // 2. 객체는 Quad-Directional Linked List로 정의. 한국말로 뭐인지도 모르겠네.
        // 3. entrance to exit path를 따라가면서 linked list 생성
        // 4. exit to entrance path를 따라가면서 linked list 계속 생성
        // 5. linked list가 완성되면, 출력.
        // 6. Entrance에서 왼쪽으로 쭉 가면 첫 값이 나오겠지.












        try {
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
