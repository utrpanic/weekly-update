import java.io.*;

public class Solution {

    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(TestCase.stringReader);
        // BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int numberOfCase = Integer.valueOf(reader.readLine());
        for (int i = 0; i < numberOfCase; i++) {
            CookieClickerAlpha cookieClickerAlpha = new CookieClickerAlpha(reader);
            System.out.println("Case #" + (i + 1) + ": " + cookieClickerAlpha.getOutput());
        }
    }
}

class CookieClickerAlpha {

    static final long COOKIES_PER_SECOND = 2;
    double costOfFarm;
    double extraCookiesPerFarm;
    double cookiesToHave;

    double elapsedTime;
    double currentCookies;
    double cookiesPerSecond;

    CookieClickerAlpha(BufferedReader reader) throws IOException {
        String[] inputs = reader.readLine().split(" ");
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

class TestCase {

    String input;

    TestCase(String input) {
        this.input = input;
    }

    static StringReader stringReader = new StringReader(
        "4\n" +
        "30.0 1.0 2.0\n" +                  // 1.0000000
        "30.0 2.0 100.0\n" +                // 39.1666667
        "30.50000 3.14159 1999.19990\n" +   // 63.9680013
        "500.0 4.0 2000.0\n"                // 526.1904762
    );

    static TestCase testCase1 = new TestCase(
        "30.0 1.0 2.0\n"
    ); // 1.0000000
    static TestCase testCase2 = new TestCase(
        "30.0 2.0 100.0\n"
    ); // 39.1666667
    static TestCase testCase3 = new TestCase(
        "30.50000 3.14159 1999.19990\n"
    ); // 63.9680013
    static TestCase testCase4 = new TestCase(
        "500.0 4.0 2000.0\n"
    ); // 526.1904762
}