package com.example.app_native_qr_grant.domain;

import androidx.annotation.NonNull;

public interface DataCallbacks<T> {
    void callbackSuccess(@NonNull T data);
}
