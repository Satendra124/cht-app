package com.iitbhu.cht.services.screentime;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.iitbhu.cht.constants.AppConstants;

public class ScreenTime extends BroadcastReceiver {
    private final long TIME_ERROR = 1000;
    @Override
    public void onReceive(Context context, Intent intent) {
        Log.i("screenTime", "ScreenTimeService onReceive");
        if(intent.getAction().equals(Intent.ACTION_SCREEN_ON)){
            AppConstants.lastScreenOnSignal = System.currentTimeMillis();
        }
        else if(intent.getAction().equals(Intent.ACTION_SCREEN_OFF)){
            long screenOnTimeSingle = System.currentTimeMillis() - AppConstants.lastScreenOnSignal;
            if(screenOnTimeSingle < TIME_ERROR) {
                AppConstants.screenTime += screenOnTimeSingle;
            }

        }
    }
}
