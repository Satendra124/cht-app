package com.iitbhu.cht.services.database;

import android.content.Context;
import android.os.Build;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.RequiresApi;
import com.iitbhu.cht.models.UserSurroundingsData;
import com.iitbhu.cht.constants.AppConstants;
import com.iitbhu.cht.services.EndPoints;
import com.squareup.okhttp.Callback;
import com.squareup.okhttp.MediaType;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.RequestBody;
import com.squareup.okhttp.Response;

import java.io.IOException;


public class DataBaseManager {
    Context context;
    public DataBaseManager(Context context){
        this.context = context;
    }
    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
    public void addLiveLocationToDB(UserSurroundingsData userLocation, Context context){
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url(EndPoints.activity_url)
                .post(RequestBody.create(MediaType.parse("application/json; charset=utf-8"),userLocation.toJsonString()))
                .build();
        client.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(Request request, IOException e) {
                Log.d("ERROR","Error reporting to backend" + e.getMessage());

            }

            @Override
            public void onResponse(Response response) throws IOException {
                Log.d("SUCESS",response.body().string());
            }
        });
        AppConstants.isInitService = true;
        AppConstants.conversationCNT = 0;
        AppConstants.surrAudioCNT = 0;
        AppConstants.steps = 0;

    }

}
