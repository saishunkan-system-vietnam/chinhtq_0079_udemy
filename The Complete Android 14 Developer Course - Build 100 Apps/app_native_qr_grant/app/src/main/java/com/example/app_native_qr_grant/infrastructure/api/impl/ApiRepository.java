package com.example.app_native_qr_grant.infrastructure.api.impl;

import static com.example.app_native_qr_grant.infrastructure.Global.isLoading;
import static com.example.app_native_qr_grant.infrastructure.Global.routes;

import android.content.Context;

import androidx.annotation.NonNull;

import com.example.app_native_qr_grant.LoginActivity;
import com.example.app_native_qr_grant.domain.ApiService;
import com.example.app_native_qr_grant.domain.DataCallbacks;
import com.example.app_native_qr_grant.domain.model.DataResponseModel;
import com.example.app_native_qr_grant.domain.model.ResponseModel;
import com.example.app_native_qr_grant.domain.model.UserModel;
import com.example.app_native_qr_grant.infrastructure.DataStorage;
import com.example.app_native_qr_grant.infrastructure.api.ApiClient;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import retrofit2.Call;

public class ApiRepository {
    private final ApiService service;
    private final DataStorage storage;
    private final Context context;

    public ApiRepository(Context context) {
        ApiClient client = new ApiClient(context);
        this.service = client.service;
        this.storage = new DataStorage(context);
        this.context = context;
    }

    public void loginQR(@NonNull String coupon, DataCallbacks<DataResponseModel<UserModel>> callbacks) {
        Map<String, Object> form = new HashMap<>();
        form.put("action", 2);
        form.put("loginQRCode", coupon);
        isLoading.setValue(true);
        Call<DataResponseModel<UserModel>> call = service.loginService(form);
        call.enqueue(new Interceptors<UserModel>() {
            @Override
            public void onSuccess(DataResponseModel<UserModel> response) {
                callbacks.callbackSuccess(response);
            }

            @Override
            public void onFail() {
//                new DialogMessage(context, R.color.red, MSG_API_ERROR, cameraScan::startCameraScan).show();
            }
        });
    }

    public void loginAccount(@NonNull String mail, @NonNull String pass, DataCallbacks<DataResponseModel<UserModel>> callbacks) {
        Map<String, Object> form = new HashMap<>();
        form.put("action", 1);
        form.put("mail", mail);
        form.put("password",pass);
        isLoading.setValue(true);
        Call<DataResponseModel<UserModel>> call = service.loginService(form);
        call.enqueue(new Interceptors<UserModel>() {
            @Override
            public void onSuccess(DataResponseModel<UserModel> response) {
                callbacks.callbackSuccess(response);
            }

            @Override
            public void onFail() {
            }
        });
    }

    public void mobileID(DataCallbacks<String> callbacks) {
        Map<String, String> form = new HashMap<>();
        form.put("device_id", storage.readString("deviceId"));
        form.put("os_type", "android");
        Call<DataResponseModel<HashMap<String, String>>> call = service.mobileIDService(storage.readString("tenant_id"), form);
        call.enqueue(new Interceptors<HashMap<String, String>>() {
            @Override
            public void onSuccess(DataResponseModel<HashMap<String, String>> response) {
                callbacks.callbackSuccess(Objects.requireNonNull(response.getPayload().get("mobileID")));
            }

            @Override
            public void onFail() {

            }
        });
    }

    public void login(DataCallbacks<DataResponseModel<UserModel>> callbacks) {
        Call<DataResponseModel<UserModel>> call = service.checkLoginService(storage.readString("tenant_id"));
        call.enqueue(new Interceptors<UserModel>() {
            @Override
            public void onSuccess(DataResponseModel<UserModel> response) {
                callbacks.callbackSuccess(response);
            }

            @Override
            public void onFail() {
                routes.pushOffAll(LoginActivity.class);
            }
        });
    }
}
