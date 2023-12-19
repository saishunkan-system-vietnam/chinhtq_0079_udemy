package com.example.app_native_qr_grant;

import com.example.app_native_qr_grant.widgets.Appbar;

public class TemOfServiceActivity extends Appbar {

    @Override
    public void init() {
        super.init();
        setContentView(R.layout.activity_tem_of_service);
        setupAppBar();
    }

    @Override
    protected void onStart() {
        super.onStart();
        setTitleToolbar("利用規約");
    }
}