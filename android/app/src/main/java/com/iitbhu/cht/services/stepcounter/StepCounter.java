package com.iitbhu.cht.services.stepcounter;

import static android.content.Context.SENSOR_SERVICE;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.util.Log;
import android.widget.Toast;

import com.iitbhu.cht.constants.Data;

import java.util.ArrayList;
public class StepCounter implements SensorEventListener,StepListener {
    final private Context context;

    private static final String TAG = "StepCounter";
    private StepCounterModel mStepCounter;
    public StepCounter(Context context) {
        mStepCounter = new StepCounterModel();
        this.context = context;
        if(mStepCounter.getSensorManager() == null) {
            mStepCounter.setSensorManager((SensorManager) context.getSystemService(SENSOR_SERVICE));
        }
        if(mStepCounter.getAccelerationSensor() == null){
            if(mStepCounter.getSensorManager().getDefaultSensor(Sensor.TYPE_ACCELEROMETER) != null) {
                mStepCounter.setAccelerationSensor(mStepCounter.getSensorManager().getDefaultSensor(Sensor.TYPE_ACCELEROMETER));
            }
        }
        if(mStepCounter.getStepDetector() == null){
            mStepCounter.setStepDetector(new StepDetector());
        }
        mStepCounter.getStepDetector().registerStepListener(this);
        if(mStepCounter.getAccelerationDataArrayList() == null){
            mStepCounter.setAccelerationDataArrayList(new ArrayList<AccelerationData>());
        }

        mStepCounter.getSensorManager().registerListener(this, mStepCounter.getAccelerationSensor(), SensorManager.SENSOR_DELAY_NORMAL);
    }
    @Override
    public void onSensorChanged(SensorEvent sensorEvent) {
        AccelerationData newAccelerationData = new AccelerationData();
        newAccelerationData.setX(sensorEvent.values[0]);
        newAccelerationData.setY(sensorEvent.values[1]);
        newAccelerationData.setZ(sensorEvent.values[2]);
        newAccelerationData.setTime(sensorEvent.timestamp);

        mStepCounter.getAccelerationDataArrayList().add(newAccelerationData);
        mStepCounter.getStepDetector().addAccelerationData(newAccelerationData);
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }

    @Override
    public void step(AccelerationData accelerationData, StepType stepType) {
        mStepCounter.setAmountOfSteps(mStepCounter.getAmountOfSteps() + 1);
        if(stepType == StepType.WALKING) {
            mStepCounter.setWalkingSteps(mStepCounter.getWalkingSteps() + 1);
            Data.userdata.STEPS_WALKING = mStepCounter.getWalkingSteps();
        }
        else if(stepType == StepType.JOGGING) {
            mStepCounter.setJoggingSteps(mStepCounter.getJoggingSteps() + 1);
            Data.userdata.STEPS_JOGGING = mStepCounter.getJoggingSteps();
        }
        else {
            mStepCounter.setRunningSteps(mStepCounter.getRunningSteps() + 1);
            Data.userdata.STEPS_RUNNING = mStepCounter.getRunningSteps();
        }
    }
}
