package com.iitbhu.cht.services.database;

import android.content.Context;
import android.location.Location;

import com.google.android.gms.tasks.Task;
import com.iitbhu.cht.constants.Constants;
import com.iitbhu.cht.constants.Data;
import com.iitbhu.cht.models.UserAppUsage;
import com.iitbhu.cht.services.screentime.AppUsage;

import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import timber.log.Timber;

public class DataSync {
    private long lastNetworkSync;
    private long lastLocalsync;
    private final Context context;
    private Timer syncTimer;
    public DataSync(Context context) {
        this.context  = context;
        syncData();
    }
    private void syncData(){
        lastLocalsync = System.currentTimeMillis();
        lastNetworkSync = System.currentTimeMillis();
        syncTimer = new Timer();
        TimerTask timerTask = new TimerTask() {
            @Override
            public void run() {
                long curTime = System.currentTimeMillis();
                if(curTime - lastNetworkSync >= Constants.SYNC_NETWORK_INTERVAL_MS) networkSync();
                localSync();
            }
        };
        syncTimer.scheduleAtFixedRate(timerTask,1,Constants.SYNC_LOCAL_INTERVAL_MS);
    }
    private void networkSync() {
        NetworkDBManager.sync_with_local(context);
        lastNetworkSync = System.currentTimeMillis();
    }
    private void localSync(){
        List<Long> location = calculateLoc(Data.userdata.user_locations);
        int steps = Data.userdata.STEPS_JOGGING + Data.userdata.STEPS_WALKING + Data.userdata.STEPS_RUNNING;
        int amplitude = calculateAmp(Data.userdata.sound_data);
        new LocalDBManager(context).addData(location.get(0),location.get(1),steps,amplitude,lastLocalsync);
        lastLocalsync = System.currentTimeMillis();
    }

    public List<Long> calculateLoc(List<Location> locations){
        long la=0,lng=0;
        for (Location loc: locations) {
            la += loc.getLatitude();
            lng += loc.getLongitude();
        }
        if(locations.size()!=0) {
            la /= locations.size();
            lng /= locations.size();
        }
        List<Long> location = new ArrayList<>();
        location.add(la);
        location.add(lng);
        return location;
    }
    public int calculateAmp(List<Integer> amp){
        int avgAmp = 0;
        for (int a : amp) {
            avgAmp += a;
        }
        if(amp.size()==0) return 0;
        return avgAmp/amp.size();
    }
    public void close(){
        syncTimer.cancel();
    }
}
