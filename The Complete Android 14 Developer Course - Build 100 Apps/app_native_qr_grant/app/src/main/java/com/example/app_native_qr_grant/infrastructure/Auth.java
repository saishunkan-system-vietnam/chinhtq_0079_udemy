package com.example.app_native_qr_grant.infrastructure;

import static com.example.app_native_qr_grant.infrastructure.Config.MSG_APP_EXCEPTION;
import static com.example.app_native_qr_grant.infrastructure.Global.routes;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.os.Bundle;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;

import com.example.app_native_qr_grant.R;
import com.example.app_native_qr_grant.widgets.custom_dialog.DialogMessage;

public class Auth extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Thread.setDefaultUncaughtExceptionHandler((t, e) -> {
            new Thread(){
                @Override
                public void run() {
                    Looper.prepare();
                    new DialogMessage(getApplicationContext(), R.color.red,MSG_APP_EXCEPTION,()->{}).show();
                    Looper.loop();
                }
            }.start();
        });
        getWindow().getDecorView().setSystemUiVisibility(
                View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                        | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
        getWindow().setStatusBarColor(getResources().getColor(R.color.black_trans80, null));
        routes = new Routes(this);
        init();
    }

    public void init(){

    }

    public void handleUnFocus(EditText edt) {
        InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        edt.clearFocus();
        imm.hideSoftInputFromWindow(edt.getWindowToken(), 0);
    }


}

