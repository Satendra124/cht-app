/*package com.iitbhu.cht.services.database;

import android.content.ContentValues;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import com.iitbhu.cht.models.UserSurroundingsData;
import com.iitbhu.cht.constants.AppConstants;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

public class SQLDBHelper extends SQLiteOpenHelper {
    private static final int DATABASE_VERSION = 1;
    private static final String DATABASE_NAME = "locationData";
    private static final String TABLE_FIRE_STORE_LOCAL = "fireStoreLocal";
    private static final String KEY_ID = "id";
    private static final String KEY_LOCATION = "name";
    private static final String KEY_TIME_START = "time_start";
    private static final String KEY_TIME_END = "time_end";
    private static final String KEY_COORDINATE_LAT = "latitude";
    private static final String KEY_COORDINATE_LNG = "longitude";
    private static final String KEY_INDEX = "index_name";
    private static final String KEY_SURROUNDING = "surronding";
    private static final String KEY_IS_MOCKED = "is_mocked";
    private static final String KEY_SLEEP_TIME = "sleep_time";

    public SQLDBHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
        //3rd argument to be passed is CursorFactory instance
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        String CREATE_FIRE_STORE_RAW_TABLE = "CREATE TABLE " + TABLE_FIRE_STORE_LOCAL + "("
                + KEY_ID + " INTEGER PRIMARY KEY,"
                + KEY_LOCATION + " TEXT,"
                + KEY_TIME_START + " DATETIME,"
                + KEY_TIME_END + " DATETIME,"
                + KEY_COORDINATE_LAT + " TEXT,"
                + KEY_COORDINATE_LNG + " TEXT,"
                + KEY_INDEX + " TEXT,"
                + KEY_IS_MOCKED + " TEXT,"
                + KEY_SURROUNDING + " TEXT,"
                + KEY_SLEEP_TIME + "TEXT"
                + ")";
        db.execSQL(CREATE_FIRE_STORE_RAW_TABLE);
        Log.i("SQLDATABASE","------------>ON Create Called");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + DATABASE_NAME);
        // Create tables again
        onCreate(db);
    }
    public void addUserLocation(UserSurroundingsData userLocation) {
        SQLiteDatabase db = this.getWritableDatabase();
        SimpleDateFormat dateFormat = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm:ss", Locale.getDefault());
        ContentValues values = new ContentValues();
        values.put(KEY_LOCATION,userLocation.getPlace());
        values.put(KEY_COORDINATE_LAT,userLocation.getLatitude());
        values.put(KEY_COORDINATE_LNG,userLocation.getLongitude());
        values.put(KEY_INDEX,userLocation.getIndexName());
        values.put(KEY_TIME_START,dateFormat.format(userLocation.getStartTime()));
        values.put(KEY_TIME_END,dateFormat.format(userLocation.getEndTime()));
        values.put(KEY_IS_MOCKED,userLocation.isMocked());
        values.put(KEY_SURROUNDING,userLocation.getSurroundings());
        values.put(KEY_SLEEP_TIME,userLocation.getSleepTimeMins());
        // Inserting Row
        long id = db.insert(TABLE_FIRE_STORE_LOCAL, null, values);
        if(id!=-1)
        AppConstants.LAST_ROW_ID = id;
        else Log.i("addUserLocation: ","----------->Error inserting record");
        //2nd argument is String containing nullColumnHack
        db.close(); // Closing database connection
        Log.i("SQLDATABASE","------------>usersave Called");
    }
    public void updateLast(){
        SimpleDateFormat dateFormat = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm:ss", Locale.getDefault());
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put(KEY_TIME_END, dateFormat.format(Calendar.getInstance().getTime()));
        if(AppConstants.LAST_ROW_ID!=-1)
        db.update(TABLE_FIRE_STORE_LOCAL,values,KEY_ID+"="+AppConstants.LAST_ROW_ID,null);
        db.close();
    }
}
*/