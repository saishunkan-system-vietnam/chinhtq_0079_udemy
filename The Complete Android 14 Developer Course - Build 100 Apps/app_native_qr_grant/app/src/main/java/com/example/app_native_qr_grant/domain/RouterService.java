package com.example.app_native_qr_grant.domain;

import android.app.Activity;

import androidx.annotation.NonNull;

public interface RouterService {
    void push(@NonNull Class<?> cls);
    void pushOffAll(@NonNull Class<?> cls);
    void pushOff(@NonNull Class<?> cls);
    Activity getActivityRoutes();
}
