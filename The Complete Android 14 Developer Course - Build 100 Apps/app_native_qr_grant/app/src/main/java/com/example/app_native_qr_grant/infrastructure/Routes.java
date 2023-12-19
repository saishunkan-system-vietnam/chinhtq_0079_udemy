package com.example.app_native_qr_grant.infrastructure;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.example.app_native_qr_grant.LoginActivity;
import com.example.app_native_qr_grant.domain.RouterService;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Routes extends AppCompatActivity implements RouterService {
    private final AppCompatActivity activity;

    public Routes(AppCompatActivity activity){
        Log.d("ROUTER PATH","/"+activity.getClass().getSimpleName());
        this.activity = activity;
    }

    @Override
    public void push(@NonNull Class<?> cls) {
        Intent intent = new Intent(activity.getApplicationContext(),cls);
        activity.startActivity(intent);
    }

    @Override
    public void pushOffAll(@NonNull Class<?> cls) {
        Intent intent = new Intent(activity.getApplicationContext(),cls);
        activity.startActivity(intent);
        activity.finishAffinity();
    }

    @Override
    public void pushOff(@NonNull Class<?> cls) {
        Intent intent = new Intent(activity.getApplicationContext(),cls);
        activity.startActivity(intent);
        activity.finish();
    }

    @Override
    public Activity getActivityRoutes() {
        return activity;
    }
}
