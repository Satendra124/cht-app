package com.iitbhu.cht.services;

import android.Manifest;
import android.app.Service;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.os.Build;
import android.os.IBinder;
import android.provider.Settings;
import android.util.Log;


import androidx.annotation.RequiresApi;
import androidx.core.app.NotificationCompat;
import androidx.core.content.ContextCompat;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;
import com.iitbhu.cht.R;
import com.iitbhu.cht.constants.Constants;
import com.iitbhu.cht.constants.Data;
import com.iitbhu.cht.models.UserData;
import com.iitbhu.cht.services.audio.AudioServices;
import com.iitbhu.cht.services.database.DataSync;
import com.iitbhu.cht.services.stepcounter.StepCounter;

import java.util.Timer;

import timber.log.Timber;

public class UserDataService extends Service {
    private static final String TAG = UserDataService.class.getSimpleName();
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        Timber.d("Service Initiated");
        initServices();
        super.onCreate();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Constants.isInitService = true;
        serviceStart();
        return START_NOT_STICKY;
    }
    @Override
    public void onDestroy() {
        Constants.isInitService = false;
        super.onDestroy();
    }
    private void initServices(){
        Data.userdata = new UserData();

    }

    private void serviceStart(){
        Timber.d("Service has been started");
        buildNotification();
        requestLocationUpdates();
        new StepCounter(getApplicationContext());
        new AudioServices();
        new DataSync(getApplicationContext());
    }

    /**
    * Builds the notification for the service to keep running in foreground.
    * */
    private void buildNotification() {
        // Create the persistent notification
        NotificationCompat.Builder builder = new NotificationCompat.Builder(this,"GPSLive")
                .setContentTitle("Connected To IIT BHU Network")
                .setOngoing(true)
                .setSmallIcon(R.drawable.ic_notri_icon);
        startForeground(1, builder.build());
    }

    /**
    * Provides location updates every UPDATE_INTERVAL (currently 5 mins) and hence updates the curUserObject
    **/
    private void requestLocationUpdates() {
        LocationRequest request = LocationRequest.create()
                .setInterval(Constants.LOCATION_UPDATE_INTERVAL_MS)
                .setFastestInterval(Constants.LOCATION_UPDATE_INTERVAL_MS)
                .setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
        FusedLocationProviderClient client = LocationServices.getFusedLocationProviderClient(this);
        int permission = ContextCompat.checkSelfPermission(this,
                Manifest.permission.ACCESS_FINE_LOCATION);
        if (permission == PackageManager.PERMISSION_GRANTED) {
            // Request location updates
            client.requestLocationUpdates(request, new LocationCallback() {
                @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
                @Override
                public void onLocationResult(LocationResult locationResult) {
                    Location location = locationResult.getLastLocation();
                    Data.userdata.user_locations.add(location);
                }
            }, null);
        }
    }

    /*
    * Responsible for updating the count of conversation points for the use in the 5 minutes time frame where the data will be submitted in the db
    * A program to get prediction every sec and store in a map with number of predictions and hence set the max of each min to [last_5_min_surroundingAudio]
    * */
    /*
    private void requestSurroundingsUpdate(){
        try {
            AppConstants.mainClassifier = AudioClassifier.createFromFile(getApplicationContext(),AppConstants.MODEL_PATH);
        } catch (IOException e) {
            e.printStackTrace();
        }
        AudioClassifier classifier = AppConstants.mainClassifier;
        TensorAudio  tensor =  classifier.createInputTensorAudio();
        AudioRecord record = classifier.createAudioRecord();
        record.startRecording();
        Timer timer = new Timer();
        TimerTask task1 = new TimerTask() {
            @RequiresApi(api = Build.VERSION_CODES.M)
            @Override
            public void run() {
                tensor.load(record);
                List<Classifications> output = classifier.classify(tensor);
                String finalSurrounding =  output.get(0).getCategories().stream().max(new Comparator<Category>() {
                    @Override
                    public int compare(Category o1, Category o2) {
                        return Float.compare(o1.getScore(),o2.getScore());
                    }
                }).get().getLabel();
                //Log.d("HERE","THIS IS THE PREDICTION: "+finalSurrounding);
                if(finalSurrounding.equals("Speech")) AppConstants.conversationCNT++;
                AppConstants.surrAudioCNT++;
            }
        };
        timer.scheduleAtFixedRate(task1,1,1000);
    }
*/

}
