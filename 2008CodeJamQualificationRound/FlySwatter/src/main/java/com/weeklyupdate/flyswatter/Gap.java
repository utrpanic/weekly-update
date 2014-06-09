package com.weeklyupdate.flyswatter;

public class Gap {
    public static final int TYPE_COMPLETE = 0;
    public static final int TYPE_TOPRIGHT_CUT_ONLY = 3;
    public static final int TYPE_TOP_CUT = 1;
    public static final int TYPE_RIGHT_CUT = 2;
    public static final int TYPE_TOP_AND_RIGHT_CUT = 4;

    int type;

    Point bottomLeft;
    Point bottomRight;
    Point topLeft;
    Point topRight;

    Point onCircleA;
    Point onCircleB;

    public Gap(double bottomLeftX, double bottomLeftY, double gap) {
        bottomLeft = new Point(bottomLeftX, bottomLeftY);
        bottomRight = new Point(bottomLeftX + gap, bottomLeftY);
        topLeft = new Point(bottomLeftX, bottomLeftY + gap);
        topRight = new Point(bottomLeftX + gap, bottomLeftY + gap);
    }

    public void determineType(double radius) {
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
        }
    }

}

class Point {
    double x, y;

    Point(double x, double y) {
        this.x = x;
        this.y = y;
    }

    boolean isInRadius(double radius) {
        return (radius * radius) > (x * x + y * y);
    }
}
