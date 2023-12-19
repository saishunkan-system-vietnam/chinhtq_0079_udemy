package com.example.app_native_qr_grant.infrastructure;

import android.content.res.Resources;

import androidx.appcompat.app.AppCompatActivity;

import com.example.app_native_qr_grant.widgets.custom_dialog.DialogMessage;

public class Utils {
    public static int convertPixelsToDp(int px){
        return (int) (px * Resources.getSystem().getDisplayMetrics().density);
    }
    //    private AppCompatActivity getActivity(Context context) {
//        if (context instanceof Activity) return (AppCompatActivity) context;
//        if (context instanceof ContextWrapper)
//            return getActivity(((ContextWrapper) context).getBaseContext());
//        return null;
//    }
}