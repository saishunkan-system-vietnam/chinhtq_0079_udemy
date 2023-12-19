package com.example.app_native_qr_grant;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.view.MenuItem;
import android.widget.TextView;

import com.example.app_native_qr_grant.widgets.Appbar;
import com.google.android.material.navigation.NavigationView;

public class HomeActivity extends Appbar implements NavigationView.OnNavigationItemSelectedListener {

    private DrawerLayout drawerLayout;

    TextView btnSubsidize, btnHistory, btnStatus, btnReject;

    @Override
    public void init() {
        super.init();
        setContentView(R.layout.activity_navigation_drawer);
        setupAppBar();
        toolbar.removeView(iconBack);
        drawerLayout = findViewById(R.id.drawer_layout);
        btnSubsidize = findViewById(R.id.btn_subsidize);
        btnHistory = findViewById(R.id.btn_history);
        btnStatus = findViewById(R.id.btn_status);
        btnReject = findViewById(R.id.btn_reject);
        NavigationView navigationView = findViewById(R.id.drawer_view);
        navigationView.setNavigationItemSelectedListener(this);

        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(this, drawerLayout, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawerLayout.addDrawerListener(toggle);
        toggle.syncState();
    }

    @Override
    protected void onStart() {
        super.onStart();
        setTitleToolbar("メインメニュー");
        btnSubsidize.setOnClickListener(v ->{
            Intent intent = new Intent(HomeActivity.this, ApplyActivity.class);
            startActivity(intent);
        });
        btnHistory.setOnClickListener(v ->{});
        btnStatus.setOnClickListener(v ->{});
        btnReject.setOnClickListener(v ->{});
    }

    @SuppressLint("NonConstantResourceId")
    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        Intent intent = null;
        switch (item.getItemId()){
            case R.id.privacy_policy:
            case R.id.logout:
                break;
            case R.id.license:
                intent = new Intent(HomeActivity.this, LicenseActivity.class);
                break;
            case R.id.terms_of_service:
                intent = new Intent(HomeActivity.this, TemOfServiceActivity.class);
                break;
        }
        startActivity(intent);
        drawerLayout.closeDrawer(GravityCompat.START);
        return true;
    }
}