package com.example.app_native_qr_grant;

import static com.example.app_native_qr_grant.infrastructure.Global.cameraPreview;
import static com.example.app_native_qr_grant.infrastructure.Global.isLoading;
import static com.example.app_native_qr_grant.infrastructure.Global.routes;
import static com.example.app_native_qr_grant.infrastructure.Global.userData;

import android.util.Log;

import androidx.activity.OnBackPressedCallback;
import androidx.annotation.NonNull;
import androidx.databinding.DataBindingUtil;
import androidx.lifecycle.LiveData;

import com.example.app_native_qr_grant.databinding.ActivityLoginScanBinding;
import com.example.app_native_qr_grant.infrastructure.DataStorage;
import com.example.app_native_qr_grant.infrastructure.api.impl.ApiRepository;
import com.example.app_native_qr_grant.widgets.Appbar;
import com.example.app_native_qr_grant.widgets.CameraPreview;
import com.google.mlkit.vision.barcode.common.Barcode;

import java.util.Objects;

public class LoginScanActivity extends Appbar {
    private ActivityLoginScanBinding binding;
    private ApiRepository api;
    private DataStorage storage;

    @Override
    public void init() {
        super.init();
        binding = DataBindingUtil.setContentView(this, R.layout.activity_login_scan);
        cameraPreview = new CameraPreview(this, findViewById(R.id.camera_preview), readerQRCode());
        this.api = new ApiRepository(this);
        this.storage = new DataStorage(this);
        setupAppBar();
        cameraPreview.reinstallAppBar(this);
        isLoading().observe(this, loading -> {
            lockBackButton(loading);
            binding.txtChangeAcc.setOnClickListener(v -> {
                if (!loading) {
                    routes.pushOff(LoginAccountActivity.class);
                }
            });
            isBack(loading);
        });
    }

    @Override
    protected void onStart() {
        super.onStart();
        setTitleToolbar("QRコードログイン");
    }

    private CameraPreview.OnReader readerQRCode() {
        return barcodes -> {
            if (barcodes.size() == 1) {
                Barcode barcode = barcodes.get(0);
                String code = Objects.requireNonNull(barcode.getRawValue());
                Log.i("Barcode Value", code);
                if (code.length() < 6) return;
                if (!code.startsWith("hojo.")) return;
                cameraPreview.mediaPlayer.start();
                cameraPreview.stopCamera();
                storage.writeString("tenant_id", "miyagi");
                storage.writeString("token", "chinhtao1908@nguyenthao0706");
                routes.pushOffAll(HomeActivity.class);
//                api.loginQR(code.substring(5), data -> {
//                    userData.setValue(data.getPayload());
//                    storage.writeString("tenant_id", data.getPayload().getTenantid());
//                    storage.writeString("token", data.getPayload().getToken());
//                    api.mobileID(data1 -> {
//                        storage.writeString("mobile_id",data1);
//                    });
//                    routes.pushOffAll(HomeActivity.class);
//                });
            }
        };
    }

    private void lockBackButton(Boolean enabled) {
        this.getOnBackPressedDispatcher().addCallback(this, new OnBackPressedCallback(true) {
            @Override
            public void handleOnBackPressed() {
                if (!enabled) {
                    finish();
                }
            }
        });
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == 101 && grantResults.length > 0) {
            cameraPreview.startCamera();
        }
    }

    private LiveData<Boolean> isLoading() {
        return isLoading;
    }
}