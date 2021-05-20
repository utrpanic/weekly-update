import java.util.*;
import java.io.*;

public class Solution {

    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(
            new StringReader(
                "5\n" + 
                "0.250000 1.000000 0.100000 0.010000 0.500000\n" + 
                "0.250000 1.000000 0.100000 0.010000 0.900000\n" + 
                "0.000010 10000.000000 0.000010 0.000010 1000.000000\n" + 
                "0.400000 10000.000000 0.000010 0.000010 700.000000\n" + 
                "1.000000 100.000000 1.000000 1.000000 10.000000"
            )
        );
        // BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int t = Integer.parseInt(reader.readLine());
        for (int i = 0; i < t; ++i) {
            FlySwatter flySwatter = new FlySwatter(reader);
            System.out.println("Case #" + (i + 1) + ": " + flySwatter.output());
        }
    }
}

class FlySwatter {

    double fly;
    double radiusOfRacquet;
    double thickness;
    double radiusOfString;
    double gap;

    FlySwatter(BufferedReader reader) throws IOException {
        String[] inputs = reader.readLine().split(" ");
        fly = Double.parseDouble(inputs[0]);
        radiusOfRacquet = Double.parseDouble(inputs[1]);
        thickness = Double.parseDouble(inputs[2]);
        radiusOfString = Double.parseDouble(inputs[3]);
        gap = Double.parseDouble(inputs[4]);
    }

    String output() {
        double quarterAreaOfRacquet = Math.PI * radiusOfRacquet * radiusOfRacquet / 4.0;
        radiusOfRacquet -= thickness + fly;
        radiusOfString += fly;
        gap -= fly * 2;

        double quaterAreaOfGap = 0;
        for (double bottomLeftOfGapX = radiusOfString; bottomLeftOfGapX < radiusOfRacquet; bottomLeftOfGapX += gap + radiusOfString * 2) {
            for (double bottomLeftOfGapY = radiusOfString; bottomLeftOfGapY < radiusOfRacquet; bottomLeftOfGapY += gap + radiusOfString * 2) {
                double gapArea = new Gap(bottomLeftOfGapX, bottomLeftOfGapY, gap, radiusOfRacquet).getArea();
                quaterAreaOfGap += gapArea;
            }
        }
        double output = 1.0 - (quaterAreaOfGap / quarterAreaOfRacquet);
        return String.format("%.6f", output);
    }
}

class Gap {

    double radius;

    double x1, y1;
    double x2, y2;

    Gap(double bottomLeftX, double bottomLeftY, double gap, double radius) {
        this.radius = radius;
        this.x1 = bottomLeftX;
        this.y1 = bottomLeftY;
        this.x2 = this.x1 + gap;
        this.y2 = this.y1 + gap;
    }

    double getArea() {
        if (x2 <= x1 || y2 <= y1) {
            return 0;
        } else if (x1 * x1 + y1 * y1 >= radius * radius) {
            return 0;
        } else if (x2 * x2 + y2 * y2 <= radius * radius) {
            // All points are inside circle.
            return (x2 - x1) * (y2 - y1);
        } else if ((x1 * x1 + y2 * y2 >= radius * radius) && (x2 * x2 + y1 * y1 >= radius * radius)) {
            // Only (x1,y1) inside circle.
            return circleSegment(Math.acos(x1 / radius) - Math.asin(y1 / radius))
                    + (Math.sqrt(radius * radius - x1 * x1) - y1) * (Math.sqrt(radius * radius - y1 * y1) - x1) / 2;
        } else if (x1 * x1 + y2 * y2 >= radius * radius) {
            // (x1,y1) and (x2,y1) inside circle.
            return circleSegment(Math.acos(x1 / radius) - Math.acos(x2 / radius))
                    + (x2 - x1) * (Math.sqrt(radius * radius - x1 * x1) - y1 + Math.sqrt(radius * radius - x2 * x2) - y1) / 2;
        } else if (x2 * x2 + y1 * y1 >= radius * radius) {
            // (x1,y1) and (x1,y2) inside circle.
            return circleSegment(Math.asin(y2 / radius) - Math.asin(y1 / radius))
                    + (y2 - y1) * (Math.sqrt(radius * radius - y1 * y1) - x1 + Math.sqrt(radius * radius - y2 * y2) - x1) / 2;
        } else {
            // All except (x2,y2) inside circle.
            return circleSegment(Math.asin(y2 / radius) - Math.acos(x2 / radius))
                    + (x2 - x1) * (y2 - y1) - (y2 - Math.sqrt(radius * radius - x2 * x2)) * (x2 - Math.sqrt(radius * radius - y2 * y2)) / 2;
        }
    }

    private double circleSegment(double th) {
        return radius * radius * (th - Math.sin(th)) / 2;
    }
}
