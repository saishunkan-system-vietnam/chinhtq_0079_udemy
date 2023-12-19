package com.example.app_native_qr_grant;

import static com.example.app_native_qr_grant.infrastructure.Global.routes;

import android.widget.TextView;

import com.example.app_native_qr_grant.infrastructure.Auth;

public class LoginActivity extends Auth {
    private TextView btnLoginAccount, btnLoginQR;

    @Override
    public void init() {
        super.init();
        setContentView(R.layout.activity_login);
        btnLoginAccount = findViewById(R.id.btn_login_account);
        btnLoginQR = findViewById(R.id.btn_login_qr);
    }

    @Override
    protected void onStart() {
        super.onStart();
        btnLoginAccount.setOnClickListener(v -> routes.push(LoginAccountActivity.class));
        btnLoginQR.setOnClickListener(v -> routes.push(LoginScanActivity.class));
    }
}