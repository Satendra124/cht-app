package com.iitbhu.cht;


import android.Manifest;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.Toast;

import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.iitbhu.cht.constants.AppConstants;
import com.iitbhu.cht.services.UserDataService;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final int PERMISSIONS_REQUEST = 1;
    private static final int RECORD_AUDIO_REQUEST_CODE = 0;

    @RequiresApi(api = Build.VERSION_CODES.Q)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), "service_channel")
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("startLocationServer")) {
                                AppConstants.ROLL_NO = call.argument("roll");
                                if (!AppConstants.isInitService) {
                                    initService();
                                }
                            } else if (call.method.equals("checkIfServiceStart")) {
                                result.success(AppConstants.isInitService);
                            } else {
                                result.notImplemented();
                            }
                        }
                );

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), "utility")
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("permission_request")) {
                                if (
                                          ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED
                                        ||ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED
                                        || ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED
                                ) {
                                    ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.RECORD_AUDIO, Manifest.permission.WRITE_EXTERNAL_STORAGE},
                                            RECORD_AUDIO_REQUEST_CODE);
                                }
                                if (ContextCompat.checkSelfPermission(this,Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                                    ActivityCompat.requestPermissions(this,
                                            new String[]{Manifest.permission.ACCESS_FINE_LOCATION},
                                            PERMISSIONS_REQUEST);
                                }
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
        if (!AppConstants.isInitService) {
            // Start the service when the permission is granted
            startTrackerService();
        } else {
            Toast.makeText(this, "Grant Permission and restart app", Toast.LENGTH_LONG).show();
        }
    }
}
