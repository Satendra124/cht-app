package com.iitbhu.cht.services.screentime;

import android.app.usage.UsageStats;
import android.app.usage.UsageStatsManager;
import android.content.Context;

import com.iitbhu.cht.constants.Constants;
import com.iitbhu.cht.models.UserAppUsage;

import java.util.ArrayList;
import java.util.List;

import timber.log.Timber;

public class AppUsage {
    final Context context;
    final long beginTimeMili;
    final long endTimeMili;
    public AppUsage(Context context, long beginTimeMili, long endTimeMili) {
        this.context = context;
        this.beginTimeMili = beginTimeMili;
        this.endTimeMili = endTimeMili;

    }
    public static List<UserAppUsage> getUsage(Context context,long beginTimeMili, long endTimeMili){
        UsageStatsManager mUsageStatsManager;
        mUsageStatsManager = (UsageStatsManager)context.getSystemService(Context.USAGE_STATS_SERVICE);
        List<UsageStats> queryUsageStats = mUsageStatsManager.queryUsageStats(UsageStatsManager.INTERVAL_BEST, beginTimeMili, endTimeMili);
        List<UserAppUsage> userUsages = new ArrayList<>();
        for( UsageStats usage:queryUsageStats ){
            userUsages.add(new UserAppUsage(usage.getPackageName(),usage.getTotalTimeInForeground(),usage.getLastTimeUsed()));
        }
        return userUsages;
    }
}