package com.iitbhu.cht.services.database;

import android.content.Context;
import android.location.Location;
import android.os.Build;

import androidx.annotation.RequiresApi;

import com.iitbhu.cht.constants.Constants;
import com.iitbhu.cht.constants.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

public class DataSync {
    private long lastNetworkSync;
    private LocalDateTime lastLocalsync;
    private final Context context;
    private Timer syncTimer;
    @RequiresApi(api = Build.VERSION_CODES.O)
    public DataSync(Context context) {
        this.context  = context;
        syncData();
    }
    @RequiresApi(api = Build.VERSION_CODES.O)
    private void syncData(){
        lastLocalsync = LocalDateTime.now();
        lastNetworkSync = System.currentTimeMillis();
        syncTimer = new Timer();
        TimerTask timerTask = new TimerTask() {
            @RequiresApi(api = Build.VERSION_CODES.O)
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
    @RequiresApi(api = Build.VERSION_CODES.O)
    private void localSync(){
        List<Double> location = calculateLoc(Data.userdata.user_locations);
        int steps = Data.userdata.STEPS_JOGGING + Data.userdata.STEPS_WALKING + Data.userdata.STEPS_RUNNING;
        int amplitude = calculateAmp(Data.userdata.sound_data);
        new LocalDBManager(context).addData(location.get(0),location.get(1),steps,amplitude,lastLocalsync);
        lastLocalsync = LocalDateTime.now();
    }

    public List<Double> calculateLoc(List<Location> locations){
        double la=0,lng=0;
        for (Location loc: locations) {
            la += loc.getLatitude();
            lng += loc.getLongitude();
        }
        if(locations.size()!=0) {
            la /= locations.size();
            lng /= locations.size();
        }
        List<Double> location = new ArrayList<>();
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
