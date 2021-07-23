package com.iitbhu.cht.constants;

import com.iitbhu.cht.models.UserSurroundingsData;

import org.tensorflow.lite.task.audio.classifier.AudioClassifier;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

public class AppConstants {
    public static String ROLL_NO = "Anonymous";
    public static long MIN_INTERVAL_FETCH = 120000;
    public static long INTERVAL_FETCH = 300000;

    public static long LAST_ROW_ID = -1;
    public static boolean isInitService = false;
    public static String MODEL_PATH = "yamnet.tflite";
    public static float probabbilityThreshold = 0.3f;
    public static AudioClassifier mainClassifier;

    public static String userUid = "tT7LbyAWwJQ53cCAS5wJIPllHo73";


    public static UserSurroundingsData curUser = new UserSurroundingsData(AppConstants.userUid);
    public static int conversationCNT = 0;
    public static int surrAudioCNT = 0;
    public static long screenTime = 0;
    public static long lastScreenOnSignal = System.currentTimeMillis();

    public static int steps = 0;
}