package com.iitbhu.cht.services.audio;

import android.media.AudioFormat;
import android.media.AudioRecord;
import android.media.MediaRecorder;
import android.os.Environment;
import android.util.Log;

import com.iitbhu.cht.constants.Data;


public class AudioServices {
    private AudioRecord mAudioRecorder ;
    private static final int RECORDER_SAMPLERATE = 8000;
    private static final int RECORDER_CHANNELS = AudioFormat.CHANNEL_IN_MONO;
    private static final int RECORDER_AUDIO_ENCODING = AudioFormat.ENCODING_PCM_16BIT;
    int BufferElements2Rec = 1024; // want to play 2048 (2K) since 2 bytes we use only 1024
    int BytesPerElement = 2; // 2 bytes in 16bit format
    private static boolean isRecording = false;

    public AudioServices(){
        mAudioRecorder = new AudioRecord(MediaRecorder.AudioSource.MIC,RECORDER_SAMPLERATE,RECORDER_CHANNELS,RECORDER_AUDIO_ENCODING,BufferElements2Rec*BytesPerElement);
        mAudioRecorder.startRecording();
        isRecording = true;
        Thread recordingThread = new Thread(new Runnable() {
            public void run() {
                analyseAudio();
            }
        }, "AudioRecorder Thread");
        recordingThread.start();
    }
    private void analyseAudio(){
        short sData[] = new short[BufferElements2Rec];
        while (isRecording) {
            int total = 0;
            mAudioRecorder.read(sData, 0, BufferElements2Rec);
            for(short d:sData) total += Math.abs(d);
            int avg = total/BufferElements2Rec;
            //Log.d("avg",String.valueOf(avg));
            Data.userdata.sound_data.add(avg);
        }
    }
    public void close(){
        isRecording = false;
        mAudioRecorder.release();
        mAudioRecorder.stop();
        mAudioRecorder = null;
    }
}
