package com.example.app_native_qr_grant;

import static com.example.app_native_qr_grant.infrastructure.Config.QRcodeLimit;
import static com.example.app_native_qr_grant.infrastructure.Global.cameraPreview;
import static com.example.app_native_qr_grant.infrastructure.Global.routes;

import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.databinding.DataBindingUtil;
import androidx.lifecycle.ViewModelProvider;

import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

import com.example.app_native_qr_grant.application.ApplyScanProvider;
import com.example.app_native_qr_grant.databinding.ActivityApplyBinding;
import com.example.app_native_qr_grant.databinding.ActivityCameraScanBinding;
import com.example.app_native_qr_grant.widgets.Appbar;
import com.example.app_native_qr_grant.widgets.CameraPreview;
import com.google.mlkit.vision.barcode.common.Barcode;

import java.text.MessageFormat;
import java.util.Objects;

public class ApplyActivity extends Appbar {
    private ActivityApplyBinding binding;
    private TextView txtCount;
    private ApplyScanProvider provider;
    private ActivityCameraScanBinding view;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = DataBindingUtil.setContentView(this, R.layout.activity_apply);

//        cameraPreview = new CameraPreview(this, view.camera, readerQRCode());
//        view.txtCountCoupon.setText("1");
        provider = new ViewModelProvider(this).get(ApplyScanProvider.class);
//        provider.getCount().observe(this, s -> txtCount.setText(s));
        setupAppBar();
//        startCameraScan();
    }

    @Override
    protected void onStart() {
        super.onStart();
        setTitleToolbar("補助金申請");
//        setHeightCamera(0.25);
    }

    private CameraPreview.OnReader readerQRCode() {
        return barcodes -> {
            for (Barcode value : barcodes) {
                if (provider.listCoupon.contains(value.getRawValue())) {
                    return;
                }
                if (provider.listCoupon.size() < QRcodeLimit) {
                    cameraPreview.mediaPlayer.start();
                    provider.listCoupon.add(value.getRawValue());
                    provider.count.setValue(MessageFormat.format("{0}", provider.listCoupon.size()));
                }
            }
        };
    }
}