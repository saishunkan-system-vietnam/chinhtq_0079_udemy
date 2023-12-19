package com.example.app_native_qr_grant.widgets.custom_button;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.DrawableContainer;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.StateListDrawable;
import android.util.AttributeSet;
import android.view.Gravity;

import androidx.appcompat.widget.AppCompatTextView;

import com.example.app_native_qr_grant.R;

import java.util.Objects;

public class PrimaryButton extends AppCompatTextView {
    public PrimaryButton(Context context, AttributeSet attrs) {
        super(context,attrs);
        setBackgroundResource(R.drawable.button_background_primary);
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.PrimaryButton, 0, 0);
        try {
            setGravity(Gravity.CENTER);
            float primaryRadius = a.getFloat(R.styleable.PrimaryButton_primaryRadius,30);
            int primary = a.getColor(R.styleable.PrimaryButton_primary, Color.parseColor("#FF2053A1"));
            for(int i =0; i < 4; i++){
                if(i != 3){
                    String hex = "#B3" + Integer.toHexString(primary).substring(2);
                    getDrawable(i).setColor(Color.parseColor(hex));
                }else {
                    getDrawable(i).setColor(primary);
                }
                getDrawable(i).setCornerRadius(primaryRadius * Resources.getSystem().getDisplayMetrics().density);
            }
        }finally {
            a.recycle();
        }
    }

    private GradientDrawable getDrawable(int index){
        StateListDrawable stateListDrawable = (StateListDrawable) getBackground();
        DrawableContainer.DrawableContainerState drawableContainerState = (DrawableContainer.DrawableContainerState) stateListDrawable.getConstantState();
        Drawable[] children = Objects.requireNonNull(drawableContainerState).getChildren();
        return (GradientDrawable) children[index];
    }
}
