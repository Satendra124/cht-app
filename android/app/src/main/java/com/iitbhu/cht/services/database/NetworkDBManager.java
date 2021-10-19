package com.iitbhu.cht.services.database;
import android.content.Context;
import android.os.Build;
import android.text.format.DateUtils;
import android.util.Log;

import androidx.annotation.RequiresApi;

import com.iitbhu.cht.constants.Constants;
import com.iitbhu.cht.constants.EndPoints;
import com.iitbhu.cht.models.UserAppUsage;
import com.iitbhu.cht.services.screentime.AppUsage;
import com.squareup.okhttp.Callback;
import com.squareup.okhttp.MediaType;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.RequestBody;
import com.squareup.okhttp.Response;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import timber.log.Timber;

public class NetworkDBManager {
    public static void sync_with_local(Context context) {
        Timber.d("NETWORK SYNC");
        LocalDBManager db = new LocalDBManager(context);
        JSONArray data = db.get_async_data();
        Calendar day = Calendar.getInstance();
        day.set(Calendar.MILLISECOND, 0);
        day.set(Calendar.SECOND, 0);
        day.set(Calendar.MINUTE, 0);
        day.set(Calendar.HOUR_OF_DAY, 0);
        long midnight =day.getTimeInMillis();
        List<UserAppUsage> usageData = AppUsage.getUsage(context,midnight,System.currentTimeMillis());
        StringBuilder usageDataString = new StringBuilder();
        for(UserAppUsage us:usageData) usageDataString.append(us.toString());
        //data.put(usageDataString);
        JSONObject res = new JSONObject();
        try {
            JSONObject json = new JSONObject();
            json.put("data",data);
            res.put("data", json);
            res.put("usagedata",usageDataString);
            res.put("useruid", Constants.userUid);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url(EndPoints.data_dump)
                .post(RequestBody.create(MediaType.parse("application/json; charset=utf-8"),res.toString()))
                .build();
        client.setConnectTimeout(30, TimeUnit.SECONDS);
        client.setReadTimeout(30, TimeUnit.SECONDS);
        client.setWriteTimeout(30, TimeUnit.SECONDS);
        client.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(Request request, IOException e) {
                e.printStackTrace();
                Timber.e("Failed to upload data to server" );
            }
            @Override
            public void onResponse(Response response) throws IOException {
                Timber.e("Success to upload data to server: %s", response.message());
                db.update_async_data();
            }
        });
    }
}
