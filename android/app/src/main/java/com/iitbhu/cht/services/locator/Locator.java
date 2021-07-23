package com.iitbhu.cht.services.locator;

import android.location.Location;
import android.os.Build;
import android.util.Log;

import androidx.annotation.RequiresApi;

import com.squareup.okhttp.Callback;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;

import org.json.JSONObject;

import java.io.IOException;

/**
 * This gives the place and respective index for a location
 * @required INTERNET
 * X-------------------NOT USING NOW------------------------------X
 * */
public class Locator {
    Location location;
    String place;
    String index;
    public Locator(Location loc){
        this.location = loc;
        fetchPlaceAndIndex();
    }
    public String getPlace(){
        return place;
    }
    public String getIndex(){
        return index;
    }

    private void fetchPlaceAndIndex(){
        double lat = location.getLatitude();
        double lng = location.getLongitude();
        String tilesetIdBuildings = "satendra124.2vcxds0t";
        String tilesetIdCampus = "satendra124.6lcp2e06";
        String ACCESS_TOKEN =
                "pk.eyJ1Ijoic2F0ZW5kcmExMjQiLCJhIjoiY2tsbDNvaWZuMTM1NDJwbm1pZWZtZmt2ZSJ9.LbmaxYdRppOSYsS3kU0SOQ";
        String queryUrlOncampus =
                "https://api.mapbox.com/v4/"+tilesetIdCampus+"/tilequery/"+lng+","+lat+".json?access_token="+ACCESS_TOKEN;

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
        .url(queryUrlOncampus)
                .build();
        client.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(Request request, IOException e) {
                e.printStackTrace();
            }

            @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
            @Override
            public void onResponse(Response response) throws IOException {
                try{
                    String resOn = response.body().string();
                    JSONObject onCampusResJ = new JSONObject(resOn);
                    Log.i("resOn",resOn);
                    if(onCampusResJ.getJSONArray("features").length()==0){
                        //addLiveLocationToFire(new UserSurroundingsData(location,"Out of Campus","Out of Campus", AppConstants.last_5_min_surroundingAudio),context);
                    }else{
                        String queryUrlOnBuildings =
                                "https://api.mapbox.com/v4/"+tilesetIdBuildings+"/tilequery/"+lng+","+lat+".json?radius=10&access_token="+ACCESS_TOKEN;
                        Request requestB = new Request.Builder()
                                .url(queryUrlOnBuildings)
                                .build();
                        client.newCall(requestB).enqueue(new Callback() {
                            @Override
                            public void onFailure(Request request, IOException e) {
                                e.printStackTrace();
                            }

                            @Override
                            public void onResponse(Response responseB) throws IOException {
                                try {
                                    String responceString = responseB.body().string();
                                    Log.i("resOn",responceString);
                                    JSONObject buildingJ = new JSONObject(responceString);
                                    if (buildingJ.getJSONArray("features").length() == 0){}
                                        /*addLiveLocationToFire(new UserSurroundingsData(
                                                location,
                                                "Inside IIT BHU",
                                                "Other", AppConstants.last_5_min_surroundingAudio),context);*/
                                    else{
                                        //Log.d("LOCATION: ",responceString);
                                        /*addLiveLocationToFire(new UserSurroundingsData(
                                                        location,
                                                        buildingJ.getJSONArray("features").getJSONObject(0).getJSONObject("properties").getString("Name"),
                                                        buildingJ.getJSONArray("features").getJSONObject(0).getJSONObject("properties").getString("Source"), AppConstants.last_5_min_surroundingAudio),
                                                context)*/;
                                    }
                                }catch (Exception e){
                                    e.printStackTrace();
                                    Log.d("onResponse:inside ","Error");
                                }
                            }
                        });
                    }
                }catch (Exception e){
                    e.printStackTrace();
                    Log.d("onResponse:outside ","Error");
                }



            }
        });
    }
}
