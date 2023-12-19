package com.example.app_native_qr_grant.widgets.custom_button;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Color;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.databinding.BindingAdapter;

import com.example.app_native_qr_grant.R;
import com.google.android.material.progressindicator.CircularProgressIndicator;

public class LoadingButton extends LinearLayout {
    public LoadingButton(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        setBackgroundResource(R.drawable.button_background_loading);
        CircularProgressIndicator loading;
        loading = new CircularProgressIndicator(getContext());
        loading.setIndeterminate(true);
        loading.setIndicatorColor(Color.parseColor("#FF2053A1"));
        loading.setLayoutParams(new ViewGroup.LayoutParams(getHeight()-3, getHeight()-3));
        setGravity(Gravity.CENTER);
        addView(loading);
    }
}
