package com.example.app_native_qr_grant.infrastructure;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;

public class DataStorage {
    private final SharedPreferences sharedPreferences;
    private final SharedPreferences.Editor editor;

    public DataStorage(@NonNull Context context) {
        this.sharedPreferences = context.getSharedPreferences("config_data",Context.MODE_PRIVATE);
        this.editor = sharedPreferences.edit();
    }

    public void writeString(String key, String value){
        this.editor.putString(key, value);
        this.editor.apply();
    }

    public String readString(String key){
        return this.sharedPreferences.getString(key, "");
    }
}
