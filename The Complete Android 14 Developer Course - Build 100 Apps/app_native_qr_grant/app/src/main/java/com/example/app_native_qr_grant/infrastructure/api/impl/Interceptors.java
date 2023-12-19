package com.example.app_native_qr_grant.infrastructure.api.impl;

import static com.example.app_native_qr_grant.infrastructure.Config.MSG_API_ERROR;
import static com.example.app_native_qr_grant.infrastructure.Config.MSG_API_TIMEOUT;
import static com.example.app_native_qr_grant.infrastructure.Global.isLoading;
import static com.example.app_native_qr_grant.infrastructure.Global.routes;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import com.example.app_native_qr_grant.LoginActivity;
import com.example.app_native_qr_grant.LoginScanActivity;
import com.example.app_native_qr_grant.R;
import com.example.app_native_qr_grant.SplashActivity;
import com.example.app_native_qr_grant.domain.model.DataResponseModel;
import com.example.app_native_qr_grant.domain.model.ResponseModel;
import com.example.app_native_qr_grant.widgets.custom_dialog.DialogMessage;

import java.util.Objects;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public abstract class Interceptors<T> implements Callback<DataResponseModel<T>> {

    public abstract void onSuccess(DataResponseModel<T> response);
    public abstract void onFail();

    @Override
    public void onResponse(@NonNull Call<DataResponseModel<T>> call, @NonNull Response<DataResponseModel<T>> response) {
        isLoading.setValue(false);
        Activity activity = routes.getActivityRoutes();
//        if(response.code() == 200){
//            DataResponseModel<T> body = Objects.requireNonNull(response.body());
//            if(body.getCode() != 0){
//                if(activity.getClass() == SplashActivity.class || body.getCode() == 401){
//                    routes.pushOffAll(LoginActivity.class);
//                }
//                new DialogMessage(activity.getApplicationContext(), R.color.red, body.getMessage(), () -> {}).show();
//            }else {
//                onSuccess(body);
//            }
//        } else if (response.code() == 403) {
//            routes.pushOffAll(LoginActivity.class);
//        } else if (response.code() == 504) {
//            new DialogMessage(activity.getApplicationContext(), R.color.red, MSG_API_TIMEOUT, () -> {}).show();
//        }else {
//            onFail();
//            if(activity.getClass() != LoginScanActivity.class){
//                new DialogMessage(activity.getApplicationContext(), R.color.red, MSG_API_ERROR, () -> {}).show();
//            }
//        }
    }

    @Override
    public void onFailure(@NonNull Call<DataResponseModel<T>> call, @NonNull Throwable t) {
        Log.i("FAILURE", Objects.requireNonNull(t.getMessage()));
        isLoading.setValue(false);
    }
}
