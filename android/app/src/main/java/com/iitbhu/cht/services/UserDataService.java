package com.iitbhu.cht.services;

import android.Manifest;
import android.app.Service;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.location.Location;
import android.media.AudioRecord;
import android.os.Build;
import android.os.IBinder;

import androidx.annotation.RequiresApi;
import androidx.core.app.NotificationCompat;
import androidx.core.content.ContextCompat;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;
import com.iitbhu.cht.R;
import com.iitbhu.cht.constants.AppConstants;
import com.iitbhu.cht.services.database.DataBaseManager;
import com.iitbhu.cht.services.locator.Locator;
import com.iitbhu.cht.services.screentime.ScreenTime;
import com.iitbhu.cht.services.stepcounter.SimpleStepDetector;
import com.iitbhu.cht.services.stepcounter.StepListener;

import org.tensorflow.lite.support.audio.TensorAudio;
import org.tensorflow.lite.support.label.Category;
import org.tensorflow.lite.task.audio.classifier.AudioClassifier;
import org.tensorflow.lite.task.audio.classifier.Classifications;

import java.io.IOException;
import java.util.Comparator;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

public class UserDataService extends Service implements SensorEventListener, StepListener {
    private SimpleStepDetector simpleStepDetector;
    private SensorManager sensorManager;
    private Sensor accel;

    private static final String TAG = UserDataService.class.getSimpleName();

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        AppConstants.isInitService = true;
        serviceStart();
        return START_NOT_STICKY;
    }
    @Override
    public void onDestroy() {
        AppConstants.isInitService = false;
        super.onDestroy();
    }

    private void serviceStart(){
        buildNotification();
        requestLocationUpdates();
        requestStepCounter();
        requestScreenTime();
        requestSurroundingsUpdate();

        Timer timer = new Timer();

        TimerTask task2 = new TimerTask() {
            @RequiresApi(api = Build.VERSION_CODES.M)
            @Override
            public void run() {
                dataSync();
            }
        };
        timer.scheduleAtFixedRate(task2,1,AppConstants.INTERVAL_FETCH);

    }

    private void requestScreenTime() {
        ScreenTime screenTimeBR = new ScreenTime();
        IntentFilter lockFilter = new IntentFilter();
        lockFilter.addAction(Intent.ACTION_SCREEN_ON);
        lockFilter.addAction(Intent.ACTION_SCREEN_OFF);
        registerReceiver(screenTimeBR, lockFilter);
    }



    /**
    * Builds the notification for the service to keep running in foreground.
    * */
    private void buildNotification() {
        // Create the persistent notification
        NotificationCompat.Builder builder = new NotificationCompat.Builder(this,"GPSLive")
                .setContentTitle("Connected To IIT BHU Network")
                .setOngoing(true)
                //.setContentIntent(broadcastIntent)
                .setSmallIcon(R.drawable.ic_notri_icon);
        startForeground(1, builder.build());
    }


    /**
    * Provides location updates every UPDATE_INTERVAL (currently 5 mins) and hence updates the curUserObject
    **/
    private void requestLocationUpdates() {
        LocationRequest request = new LocationRequest();
        request.setInterval(AppConstants.INTERVAL_FETCH);
        request.setFastestInterval(AppConstants.MIN_INTERVAL_FETCH);
        request.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
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
                    if (location != null) {
                        Locator locator = new Locator(location);
                        AppConstants.curUser.setLocation(location);
                    }
                }
            }, null);
        }
    }



    /**
    * Responsible for updating the count of conversation points for the use in the 5 minutes time frame where the data will be submitted in the db
    * A program to get prediction every sec and store in a map with number of predictions and hence set the max of each min to [last_5_min_surroundingAudio]
    * */
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

    /**
    * Responsible for sync user data to all the databases by comparing the last data with the help to DatabaseManager.java
    * */
    private void dataSync(){
        if(AppConstants.conversationCNT>10) AppConstants.curUser.setSurroundings("Speech");
        AppConstants.curUser.setSteps(AppConstants.steps);
        AppConstants.curUser.setScreenTime(System.currentTimeMillis() - AppConstants.lastScreenOnSignal);
        AppConstants.lastScreenOnSignal = System.currentTimeMillis();
        new DataBaseManager(getApplicationContext()).addLiveLocationToDB(AppConstants.curUser,getApplicationContext());
    }
    /**
     * Counts number of steps for user
     * */
    private void requestStepCounter() {
        sensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);
        accel = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        simpleStepDetector = new SimpleStepDetector();
        simpleStepDetector.registerListener(this);
        sensorManager.registerListener(this, accel, SensorManager.SENSOR_DELAY_FASTEST);
    }


    @Override
    public void onSensorChanged(SensorEvent event) {
        if (event.sensor.getType() == Sensor.TYPE_ACCELEROMETER) {
            simpleStepDetector.updateAccel(
                    event.timestamp, event.values[0], event.values[1], event.values[2]);
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }

    @Override
    public void step(long timeNs) {
        AppConstants.steps++;
//        Toast.makeText(this, "Steps:"+AppConstants.steps, Toast.LENGTH_SHORT).show();
    }

    /*
     * This is responsible to find if the user is sleeping or not
     * @return true if user is sleeping
     */
    /*private boolean is_sleeping(){
        return AppConstants.curUser.getIndexName().equals(Index.INDEX_1);
    }*/

}
