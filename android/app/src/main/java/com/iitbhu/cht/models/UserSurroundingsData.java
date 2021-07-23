package com.iitbhu.cht.models;

import android.location.Location;
import android.os.Build;

import androidx.annotation.RequiresApi;


import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.iitbhu.cht.services.locator.Locator;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class UserSurroundingsData {
    private double latitude;
    private double longitude;
    //private double altitude;
    //private boolean isMocked;
    //private double speed;
    //private final Date startTime;
    //private Date endTime;
    //private String place;
    //private String indexName;
    private String surroundings;
    private long screenTime;



    private int steps;
    private final String useruid;
    //private int sleepTimeMins;
    public UserSurroundingsData(Location location, String surroundings,long screenTime,String uid,int steps){
        this.surroundings = surroundings;
        //Calendar date = Calendar.getInstance();
        //long t= date.getTimeInMillis();
        //long ONE_MINUTE_IN_MILLIS=60000;
        //Date endT=new Date(t + (ONE_MINUTE_IN_MILLIS));
        this.latitude = location.getLatitude();
        this.longitude = location.getLongitude();
        this.screenTime = screenTime;
        this.useruid = uid;
        this.steps = steps;
        //this.altitude = location.getAltitude();
        //this.isMocked = location.isFromMockProvider();
        //this.speed = location.getSpeed();
        //this.startTime =date.getTime();
        //this.place = place;
        //this.endTime = endT;
        //this.indexName = indexName;
        //sleepTimeMins = 0;
    }
    public UserSurroundingsData(String uid){
        this.surroundings = "Unknown";
        //Calendar date = Calendar.getInstance();
        //long t= date.getTimeInMillis();
        //long ONE_MINUTE_IN_MILLIS=60000;
        //Date endT=new Date(t + (ONE_MINUTE_IN_MILLIS));
        this.latitude = -1;
        this.longitude = -1;
        this.useruid = uid;
        this.screenTime = 0;
        this.steps=  0;
        //this.altitude = -1;
        //this.isMocked = false;
        //this.speed = -1;
        //this.startTime =date.getTime();
        //this.place = "UNKNOWN";
        //this.endTime = endT;
        //this.indexName = "UNKNOWN";
        //sleepTimeMins = 0;
    };

    public void setLocation(Location location){
        Locator locator = new Locator(location);
        this.latitude = location.getLatitude();
        this.longitude = location.getLongitude();
        //this.altitude = location.getAltitude();
        //this.isMocked = location.isFromMockProvider();
        //this.speed = location.getSpeed();
        //this.place = locator.getPlace();
        //this.indexName = locator.getIndex();
    }


    public void setSurroundings(String surroundings){
        this.surroundings = surroundings;
    }


    @Override
    public String toString() {
        return "UserLocation{" +
                "latitude=" + latitude +
                ", longitude=" + longitude +
                //", altitude=" + altitude +
                //", isMocked=" + isMocked +
                //", speed=" + speed +
                //", startTime=" + startTime +
                //", place='" + place + '\'' +
                //", endTime='" + endTime + '\'' +
                //", indexName='" + indexName + '\'' +
                ", surroundings='" + surroundings + '\'' +
                ", screenTime='" + screenTime + '\'' +
                ", useruid='" + useruid + '\'' +
                ", steps='" + steps + '\''+
                //", sleepTimeMins='" + sleepTimeMins + '\'' +
                '}';
    }
    public String toJsonString(){
        String json = "";
        try {
            json = new JSONObject()
                    .put("latitude", latitude)
                    .put("longitude",longitude)
                    .put("soundType",surroundings)
                    .put("screenTime",String.valueOf(screenTime))
                    .put("useruid",useruid)
                    .put("steps",steps)
                    .toString();
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return json;
    }
    public Map<String,Object> toJson(){
        Map<String,Object> finalJson = new HashMap<>();
        finalJson.put("latitude",latitude);
        finalJson.put("longitude",longitude);
        //finalJson.put("altitude",altitude);
        //finalJson.put("isMocked",isMocked);
        //finalJson.put("speed",speed);
        //finalJson.put("startTime", startTime);
        //finalJson.put("place",place);
        //finalJson.put("endTime",endTime);
        //finalJson.put("indexName",indexName);
        finalJson.put("soundType",surroundings);
        finalJson.put("screenTime",screenTime);
        finalJson.put("useruid",useruid);
        finalJson.put("steps",steps);
        //finalJson.put("sleepTimeMins",sleepTimeMins);
        return finalJson;
    }

    /*public String getPlace() {
        return place;
    }

    public Date getEndTime() {
        return endTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public double getAltitude() {
        return altitude;
    }

    public String getIndexName() {
        return indexName;
    }
*/
    public double getLatitude() {
        return latitude;
    }

    public double getLongitude() {
        return longitude;
    }
/*
    public double getSpeed() {
        return speed;
    }

    public boolean isMocked() {
        return isMocked;
    }

    public void setEndTime(Date newEndTime){
        this.endTime = newEndTime;
    }
*/
    public String getSurroundings() {
        return surroundings;
    }
/*
    public int getSleepTimeMins() {
        return sleepTimeMins;
    }

    public void setSleepTimeMins(int sleepTimeMins) {
        this.sleepTimeMins = sleepTimeMins;
    }
*/
    public long getScreenTime() {
        return screenTime;
    }

    public void setScreenTime(long screenTime) {
        this.screenTime = screenTime;
    }

    public String getUid() {
        return useruid;
    }
    public int getSteps() {
        return steps;
    }

    public void setSteps(int steps) {
        this.steps = steps;
    }
}
