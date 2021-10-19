package com.iitbhu.cht.services.database;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.icu.util.LocaleData;
import android.os.Build;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import com.iitbhu.cht.constants.Constants;
import com.iitbhu.cht.models.UserAppUsage;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.*;
import java.util.List;
import java.util.Locale;

import timber.log.Timber;

public class LocalDBManager extends SQLiteOpenHelper {
    private static final int DATABASE_VERSION = 1;
    private static final String DATABASE_NAME = "cht";
    private static final String TABLE_NAME_LOCAL = "userdata";
    private static final String KEY_ID = "id";
    private static final String KEY_TIME_START = "time_start";
    private static final String KEY_TIME_END = "time_end";
    private static final String KEY_COORDINATE_LAT = "latitude";
    private static final String KEY_COORDINATE_LNG = "longitude";
    //private static final String KEY_APP_USAGE = "app_usage";
    private static final String KEY_STEPS = "steps";
    private static final String KEY_NOISE = "amplitude";
    private static final String KEY_IS_SYNC = "is_synced";
    public LocalDBManager(@Nullable Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public void addData(double latitude, double longitude, int steps, int amplitude, LocalDateTime startTime) {
        SQLiteDatabase db = this.getWritableDatabase();
        SimpleDateFormat dateFormat = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm:ss", Locale.getDefault());
        ContentValues values = new ContentValues();
        values.put(KEY_COORDINATE_LAT,latitude);
        values.put(KEY_COORDINATE_LNG,longitude);
        values.put(KEY_TIME_START, (startTime).toString());
        values.put(KEY_TIME_END, LocalDateTime.now().toString());
        values.put(KEY_STEPS,steps);
        values.put(KEY_NOISE,amplitude);
        values.put(KEY_IS_SYNC,false);
        long id = db.insert(TABLE_NAME_LOCAL, null, values);
        if(id==-1)
            Timber.e("Could not insert row");
        db.close();
        Timber.d("Data Saved to db with id %s", id);
    }
    public JSONArray get_async_data(){
        SQLiteDatabase db = this.getWritableDatabase();
        Cursor cursor=  db.rawQuery("SELECT * FROM " + TABLE_NAME_LOCAL + " WHERE "+KEY_IS_SYNC + " = 0 ORDER BY "+KEY_TIME_START+" ASC",null);
        if(cursor==null){
            Timber.e("cursor was null when attempting to get async data from database!");
            return null;
        }
        JSONArray json_data = new JSONArray();
        boolean hasNext = cursor.moveToFirst();
        //Timber.d("Rows: %d",cursor.getCount());
        while(hasNext){
            JSONObject row = new JSONObject();
            try {
                //Timber.d("Columns: %d",cursor.getColumnCount());
                //Timber.d("key: %d", cursor.getColumnIndex(KEY_ID));
                //row.put(KEY_ID,cursor.getInt(0));
                row.put(KEY_TIME_START,cursor.getString(1));
                row.put(KEY_TIME_END,cursor.getString(2));
                row.put(KEY_COORDINATE_LAT,cursor.getString(3));
                row.put(KEY_COORDINATE_LNG,cursor.getString(4));
                //row.put(KEY_APP_USAGE,cursor.getString(5));
                row.put(KEY_STEPS,cursor.getInt(5));
                row.put(KEY_NOISE,cursor.getString(6));
                row.put("useruid", Constants.userUid);
            } catch (JSONException e) {
                Timber.e(e);
            }
            json_data.put(row);
            hasNext = cursor.moveToNext();
        }
        cursor.close();
        db.close();
        return json_data;
    }
    public void update_async_data(){
        SQLiteDatabase db = this.getWritableDatabase();
        db.rawQuery("UPDATE "+TABLE_NAME_LOCAL+" SET "+KEY_IS_SYNC+"=1 WHERE "+KEY_IS_SYNC+" =0",null).close();
        db.close();
    }
    @Override
    public void onCreate(SQLiteDatabase db) {
        String CREATE_LOCAL_TABLE = "CREATE TABLE " + TABLE_NAME_LOCAL + "("
                + KEY_ID + " INTEGER PRIMARY KEY,"
                + KEY_TIME_START + " TEXT,"
                + KEY_TIME_END + " TEXT,"
                + KEY_COORDINATE_LAT + " TEXT,"
                + KEY_COORDINATE_LNG + " TEXT,"
                //+ KEY_APP_USAGE + " TEXT,"
                + KEY_STEPS + " TEXT,"
                + KEY_NOISE + " TEXT,"
                + KEY_IS_SYNC + " INTEGER"
                + ")";
        db.execSQL(CREATE_LOCAL_TABLE);
        Timber.d("Database Table created");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + DATABASE_NAME);
        onCreate(db);
    }
}
