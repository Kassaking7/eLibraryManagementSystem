package com.example.backend.entity;

public class Guest {
    private long ID;
    private Boolean isActivated;
    private int creditLevel;
    private int remainingCredit;
    private float lateFee;

    public Guest(long ID, Boolean isActivated, int creditLevel, int remainingCredit, float lateFee) {
        this.ID = ID;
        this.isActivated = isActivated;
        this.creditLevel = creditLevel;
        this.remainingCredit = remainingCredit;
        this.lateFee = lateFee;
    }

    public long getID() {
        return ID;
    }

    public void setID(long ID) {
        this.ID = ID;
    }

    public Boolean getActivated() {
        return isActivated;
    }

    public void setActivated(Boolean activated) {
        isActivated = activated;
    }

    public int getCreditLevel() {
        return creditLevel;
    }

    public void setCreditLevel(int creditLevel) {
        this.creditLevel = creditLevel;
    }

    public int getRemainingCredit() {
        return remainingCredit;
    }

    public void setRemainingCredit(int remainingCredit) {
        this.remainingCredit = remainingCredit;
    }

    public float getLateFee() {
        return lateFee;
    }

    public void setLateFee(float lateFee) {
        this.lateFee = lateFee;
    }
}
