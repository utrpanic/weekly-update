import java.util.*;
import java.io.*;

public class Solution {

    public static void main(String[] args) throws IOException {
        // BufferedReader reader = new BufferedReader(
        //     new StringReader(
        //         "5\n" +
        //         "0.250000 1.000000 0.100000 0.010000 0.500000\n" +
        //         "0.250000 1.000000 0.100000 0.010000 0.900000\n" +
        //         "0.000010 10000.000000 0.000010 0.000010 1000.000000\n" +
        //         "0.400000 10000.000000 0.000010 0.000010 700.000000\n" +
        //         "1.000000 100.000000 1.000000 1.000000 10.000000"
        //     )
        // );
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
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
        double areaOfRacquet = Math.PI * radiusOfRacquet * radiusOfRacquet;
        radiusOfRacquet -= thickness + fly;
        radiusOfString += fly;
        gap -= fly * 2;

        double bottomLeftOfGapX = radiusOfString;
        double bottomLeftOfGapY = radiusOfString;
        double totalAreaOfGap = 0;
        while (bottomLeftOfGapY <= radiusOfRacquet) {
            while (bottomLeftOfGapX <= radiusOfRacquet) {
                totalAreaOfGap += new Gap(bottomLeftOfGapX, bottomLeftOfGapY, gap, radiusOfRacquet).getArea();
                bottomLeftOfGapX += gap + radiusOfString * 2;
            }
            bottomLeftOfGapY += gap + radiusOfString * 2;
            bottomLeftOfGapX = radiusOfString;
        }

        double output = (areaOfRacquet - totalAreaOfGap * 4) / areaOfRacquet;

        return String.format("%.6f", output);
    }
}

class Gap {
    static final int TYPE_OUT_OF_CIRCLE = -1;
    static final int TYPE_COMPLETE = 0;
    static final int TYPE_TOPRIGHT_CUT_ONLY = 3;
    static final int TYPE_TOP_CUT = 1;
    static final int TYPE_RIGHT_CUT = 2;
    static final int TYPE_TOP_AND_RIGHT_CUT = 4;

    int type;

    double radius;
    double gap;

    Point bottomLeft;
    Point bottomRight;
    Point topLeft;
    Point topRight;

    Point onCircleA;
    Point onCircleB;
    double heightOfCircleSegment;

    Gap(double bottomLeftX, double bottomLeftY, double gap, double radius) {
        this.radius = radius;
        this.gap = gap;
        bottomLeft = new Point(bottomLeftX, bottomLeftY);
        bottomRight = new Point(bottomLeftX + gap, bottomLeftY);
        topLeft = new Point(bottomLeftX, bottomLeftY + gap);
        topRight = new Point(bottomLeftX + gap, bottomLeftY + gap);
    }

    double getArea() {
        determineType();
        calculatePointsOnCircle();
        return calculateArea();
    }

    private void determineType() {
        if (topRight.isInRadius(radius)) {
            type = TYPE_COMPLETE;
        } else if (bottomLeft.isInRadius(radius)){
            if (topLeft.isInRadius(radius) && bottomRight.isInRadius(radius)) {
                type = TYPE_TOPRIGHT_CUT_ONLY;
            } else if (bottomRight.isInRadius(radius)) {
                type = TYPE_TOP_CUT;
            } else if (topLeft.isInRadius(radius)) {
                type = TYPE_RIGHT_CUT;
            } else {
                type = TYPE_TOP_AND_RIGHT_CUT;
            }
        } else {
            type = TYPE_OUT_OF_CIRCLE;
        }
    }

    private void calculatePointsOnCircle() {
        switch (type) {
            case TYPE_TOPRIGHT_CUT_ONLY:
                onCircleA = new Point(getOtherAxisOfPointOnCircle(topLeft.y), topLeft.y);
                onCircleB = new Point(bottomRight.x, getOtherAxisOfPointOnCircle(bottomRight.x));
                break;
            case TYPE_TOP_CUT:
                onCircleA = new Point(bottomLeft.x, getOtherAxisOfPointOnCircle(bottomLeft.x));
                onCircleB = new Point(bottomRight.x, getOtherAxisOfPointOnCircle(bottomRight.x));
                break;
            case TYPE_RIGHT_CUT:
                onCircleA = new Point(getOtherAxisOfPointOnCircle(topLeft.y), topLeft.y);
                onCircleB = new Point(getOtherAxisOfPointOnCircle(bottomLeft.y), bottomLeft.y);
                break;
            case TYPE_TOP_AND_RIGHT_CUT:
                onCircleA = new Point(bottomLeft.x, getOtherAxisOfPointOnCircle(bottomLeft.x));
                onCircleB = new Point(getOtherAxisOfPointOnCircle(bottomLeft.y), bottomLeft.y);
                break;
        }
        if (onCircleA != null && onCircleB != null) {
            Point middlePoint = onCircleA.getMiddlePoint(onCircleB);
            double distance = middlePoint.getDistanceFromOrigin();
            heightOfCircleSegment = radius - distance;
        }
    }

    private double getOtherAxisOfPointOnCircle(double otherAxis) {
        return Math.sqrt(radius * radius - otherAxis * otherAxis);
    }

    private double calculateArea() {
        double area = 0;
        switch (type) {
            case TYPE_COMPLETE:
                area = gap * gap;
                break;
            case TYPE_TOPRIGHT_CUT_ONLY:
                area = getAreaOfCircleSegment();
                area += gap * gap - ((onCircleB.x - onCircleA.x) * (onCircleA.y - onCircleB.y) / 2.0);
                break;
            case TYPE_TOP_CUT:
                area = getAreaOfCircleSegment();
                area += gap * ((onCircleA.y - bottomLeft.y) + (onCircleB.y - bottomLeft.y)) / 2.0;
                break;
            case TYPE_RIGHT_CUT:
                area = getAreaOfCircleSegment();
                area += gap * ((onCircleA.x - bottomLeft.x) + (onCircleB.x - bottomLeft.x)) / 2.0;
                break;
            case TYPE_TOP_AND_RIGHT_CUT:
                area = getAreaOfCircleSegment();
                area += (onCircleB.x - onCircleA.x) * (onCircleA.y - onCircleB.y) / 2.0;
                break;
        }
        return area;
    }

    private double getAreaOfCircleSegment() {
        double usingHeight = getAreaOfCircleSegmentUsingHeight();
        double usingAngle = getAreaOfCircleSegmentUsingAngle();
        // System.out.println("by h: " + usingHeight + ", by a: " + usingAngle);
        return usingAngle;
    }

    private double getAreaOfCircleSegmentUsingHeight() {
        // http://www.mathopenref.com/segmentareaht.html
        return (radius * radius * Math.acos((radius - heightOfCircleSegment) / radius))
                - ((radius - heightOfCircleSegment) * Math.sqrt(2 * radius * heightOfCircleSegment - heightOfCircleSegment * heightOfCircleSegment));
    }

    private double getAreaOfCircleSegmentUsingAngle() {
        // http://www.mathopenref.com/segmentarea.html
        double angle = Math.asin(onCircleA.y/radius) - Math.asin(onCircleB.y/radius);
        return ((radius * radius) / 2.0) * (angle - Math.sin(angle));
    }

}

class Point {
    double x, y;

    Point(double x, double y) {
        this.x = x;
        this.y = y;
    }

    boolean isInRadius(double radius) {
        return radius > Math.hypot(this.x, this.y);
    }

    Point getMiddlePoint(Point point) {
        return new Point((this.x + point.x) / 2.0, (this.y + point.y) / 2.0);
    }

    double getDistanceFromOrigin() {
        return Math.hypot(this.x, this.y);
    }
}
