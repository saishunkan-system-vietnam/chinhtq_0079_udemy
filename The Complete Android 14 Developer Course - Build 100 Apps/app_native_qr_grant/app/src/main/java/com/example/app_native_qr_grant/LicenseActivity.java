package com.example.app_native_qr_grant;

import com.example.app_native_qr_grant.widgets.Appbar;

public class LicenseActivity extends Appbar {

    @Override
    public void init() {
        super.init();
        setContentView(R.layout.activity_license);
        setupAppBar();
    }

    @Override
    protected void onStart() {
        super.onStart();
        setTitleToolbar("ライセンス");
    }
}