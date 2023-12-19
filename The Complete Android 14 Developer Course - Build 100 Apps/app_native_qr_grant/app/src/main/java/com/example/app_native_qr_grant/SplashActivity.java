package com.example.app_native_qr_grant;

import static com.example.app_native_qr_grant.infrastructure.Global.routes;
import static com.example.app_native_qr_grant.infrastructure.Global.userData;

import android.annotation.SuppressLint;
import android.os.Handler;

import com.example.app_native_qr_grant.infrastructure.DataStorage;
import com.example.app_native_qr_grant.infrastructure.api.impl.ApiRepository;
import com.example.app_native_qr_grant.infrastructure.Auth;

import java.util.UUID;

@SuppressLint("CustomSplashScreen")
public class SplashActivity extends Auth {
    private DataStorage storage;
//    private ApiRepository api;

    @Override
    public void init() {
        super.init();
        setContentView(R.layout.activity_splash);
        this.storage = new DataStorage(this);
//        this.api = new ApiRepository(this);
        randomID();
        final Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                checkLogin();
            }
        }, 2000);
    }

    private void randomID() {
        if (storage.readString("deviceId").equals("")) {
            storage.writeString("deviceId", UUID.randomUUID().toString());
        }
    }

    private void checkLogin() {
        String token = storage.readString("token");
        String tenantid = storage.readString("tenant_id");

        if (token.equals("") || tenantid.equals("")) {
            routes.pushOffAll(LoginActivity.class);
        } else {
            routes.pushOffAll(HomeActivity.class);
//            api.login(data -> {
//                userData.setValue(data.getPayload());
//                storage.writeString("token", data.getPayload().getToken());
//                api.mobileID(mobileID -> {
//                    storage.writeString("mobile_id", mobileID);
//                });
//                routes.pushOffAll(HomeActivity.class);
//            });
        }
    }
}