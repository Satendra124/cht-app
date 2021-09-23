package com.iitbhu.cht.models;


public class UserAppUsage {
    private final long usageTime;
    private final String packageName;
    private final long lastUsedMilis;

    public UserAppUsage( String packageName,long usageTime, long lastUsedMilis) {
        this.usageTime = usageTime;
        this.packageName = packageName;
        this.lastUsedMilis = lastUsedMilis;
    }
    @Override
    public String toString() {
        return "{" +
                "usageTime=" + usageTime +
                ", packageName='" + packageName + '\'' +
                ", lastUsedMilis=" + lastUsedMilis +
                '}';
    }

}
