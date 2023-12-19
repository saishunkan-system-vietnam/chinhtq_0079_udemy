package com.example.app_native_qr_grant.widgets;

import android.annotation.SuppressLint;
import android.widget.TextView;

import androidx.appcompat.widget.Toolbar;

import com.example.app_native_qr_grant.R;
import com.example.app_native_qr_grant.infrastructure.Auth;

import java.util.Objects;

public class Appbar extends Auth {
    public TextView iconBack, iconTitle;
    public Toolbar toolbar;


    public void setTitleToolbar(String title) {
        iconTitle.setText(title);
    }

    @SuppressLint({"InternalInsetResource", "DiscouragedApi"})
    public int getStatusBarHeight() {
        int statusBarHeight = 0;
        int resourceId = getResources().getIdentifier("status_bar_height", "dimen", "android");
        if (resourceId > 0) {
            statusBarHeight = getResources().getDimensionPixelSize(resourceId);
        }
        return statusBarHeight;
    }

    private void registerToolbar() {
        Objects.requireNonNull(getSupportActionBar()).setTitle("");
        iconBack = findViewById(R.id.txt_back_toolbar);
        iconTitle = findViewById(R.id.txt_title_toolbar);
        isBack(false);
    }

    public void setupAppBar() {
        toolbar = findViewById(R.id.header_appbar_layout);
        setSupportActionBar(toolbar);
        int statusBarHeight = getStatusBarHeight();
        toolbar.setPadding(0, statusBarHeight, 0, 0);
        registerToolbar();
    }

    public void isBack(Boolean enable){
        iconBack.setOnClickListener(v ->{
            if(!enable){
                finish();
            }
        });
    }
}
