package com.iitbhu.cht.services.stepcounter;

/**
 *
 */
public class AccelerationData {

    private double value; // Length of the vector (calculated from x, y and z)
    private float x;
    private float y;
    private float z;
    private long time;

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public float getX() {
        return x;
    }

    public void setX(float x) {
        this.x = x;
    }

    public float getY() {
        return y;
    }

    public void setY(float y) {
        this.y = y;
    }

    public float getZ() {
        return z;
    }

    public void setZ(float z) {
        this.z = z;
    }

    public long getTime() {
        return time;
    }

    public void setTime(long time) {
        this.time = time;
    }
}
