package com.iitbhu.cht.models;

import android.location.Location;

import com.iitbhu.cht.constants.Data;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserData {
    public List<Location> user_locations;
    public final Date last_sync;
    public int STEPS_WALKING = 0;
    public int STEPS_JOGGING = 0;
    public int STEPS_RUNNING = 0;
    public List<Integer> sound_data;
    public UserData(){
        sound_data = new ArrayList<>();
        long millis=System.currentTimeMillis();
        last_sync = new java.util.Date(millis);
        user_locations = new ArrayList<>();
    }
}
