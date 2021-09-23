package com.iitbhu.cht;


import android.Manifest;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.usage.UsageStatsManager;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.LocationManager;
import android.media.MediaRecorder;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.widget.Toast;

import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.iitbhu.cht.constants.Constants;
import com.iitbhu.cht.services.UserDataService;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import timber.log.Timber;

public class MainActivity extends FlutterActivity {
    private static final int PERMISSIONS_REQUEST = 1;

    @RequiresApi(api = Build.VERSION_CODES.Q)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if(BuildConfig.DEBUG){
            Timber.plant(new Timber.DebugTree());
        }
        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), "service_channel")
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("startLocationServer")) {
                                Constants.userUid = call.argument("uid");
                                if (!Constants.isInitService) {
                                    initService();

                                }
                            } else if (call.method.equals("checkIfServiceStart")) {
                                result.success(Constants.isInitService);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    @RequiresApi(api = Build.VERSION_CODES.Q)
    private void initService() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            int importance = NotificationManager.IMPORTANCE_DEFAULT;
            NotificationChannel channel = new NotificationChannel("GPSLive", "GPSLive", importance);
            channel.setDescription("Main Notification Channel DON'T TURN OFF");
            // Register the channel with the system; you can't change the importance
            // or other notification behaviors after this
            NotificationManager notificationManager = getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(channel);
        }

        // Check GPS is enabled
        LocationManager lm = (LocationManager) getSystemService(LOCATION_SERVICE);
        if (!lm.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            Toast.makeText(this, "Please enable location services and restart app", Toast.LENGTH_LONG).show();
            //finish();
        }
        // Check location permission is granted - if it is, start
        // the service, otherwise request the permission
        int permission = ContextCompat.checkSelfPermission(this,
                Manifest.permission.ACCESS_FINE_LOCATION);
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED
                &&ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED
                &&ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED
                && ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED
                && ContextCompat.checkSelfPermission(this,Manifest.permission.ACTIVITY_RECOGNITION)== PackageManager.PERMISSION_GRANTED
                && ContextCompat.checkSelfPermission(this,Manifest.permission.READ_PHONE_STATE)== PackageManager.PERMISSION_GRANTED
        ) {
            startTrackerService();
        } else {
            startActivity(new Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS));
            ActivityCompat.requestPermissions(this,
                    new String[]{Manifest.permission.ACCESS_FINE_LOCATION,Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.RECORD_AUDIO, Manifest.permission.WRITE_EXTERNAL_STORAGE,Manifest.permission.ACTIVITY_RECOGNITION,Manifest.permission.READ_PHONE_STATE},
                    PERMISSIONS_REQUEST);
        }
    }

    private void startTrackerService() {
        startService(new Intent(this, UserDataService.class));
        //finish();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[]
            grantResults) {
        if (!Constants.isInitService) {
            // Start the service when the permission is granted
            startTrackerService();
        } else {
            Toast.makeText(this, "Grant Permission and restart app", Toast.LENGTH_LONG).show();
        }
    }
}
