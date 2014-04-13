package com.weeklyupdate.cookieclickeralpha;

import java.io.*;

public class CookieClickerAlpha {

    public static void main(String[] args) throws IOException {
        CookieClickerAlpha.process("CookieClickerAlpha/B-small-practice.in", "CookieClickerAlpha/B-small-practice.out");
        CookieClickerAlpha.process("CookieClickerAlpha/B-large-practice.in", "CookieClickerAlpha/B-large-practice.out");
    }

    private static void process(String inputFileName, String outputFileName) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader(inputFileName));
        BufferedWriter out = new BufferedWriter(new FileWriter(outputFileName));

        int numberOfCase = Integer.valueOf(in.readLine());
        CookieClickerAlpha cookieClickerAlpha = new CookieClickerAlpha();
        for (int i = 0; i < numberOfCase; i++) {
            cookieClickerAlpha.init(in.readLine());
            String output = "Case #" + (i + 1) + ": " + cookieClickerAlpha.getOutput() + "\n";
            out.write(output);
            System.out.print(output + "\n");
        }

        in.close();
        out.close();
    }

//    static final long TRICK_FOR_REAL_NUMBER = 10000000;
    static final long COOKIES_PER_SECOND = 2; // * TRICK_FOR_REAL_NUMBER;
    double costOfFarm;
    double extraCookiesPerFarm;
    double cookiesToHave;

    double elapsedTime;
    double currentCookies;
    double cookiesPerSecond;


    void init(String input) {
        String[] inputs = input.split(" ");
        costOfFarm = (Double.parseDouble(inputs[0]));
        extraCookiesPerFarm = (Double.parseDouble(inputs[1]));
        cookiesToHave = (Double.parseDouble(inputs[2]));

        elapsedTime = 0;
        currentCookies = 0;
        cookiesPerSecond = COOKIES_PER_SECOND;
    }

    String getOutput() {
        double timeToFinishBuyNewFarm, timeToFinish;
        while (true) {
            timeToFinishBuyNewFarm = (costOfFarm / cookiesPerSecond) + (cookiesToHave / (cookiesPerSecond + extraCookiesPerFarm));
            timeToFinish = cookiesToHave / cookiesPerSecond;
            if (timeToFinishBuyNewFarm > timeToFinish) {
                break;
            }
            elapsedTime += (costOfFarm / cookiesPerSecond);
            cookiesPerSecond += extraCookiesPerFarm;
        }
        return String.format("%.7f", elapsedTime + timeToFinish);
    }
}
