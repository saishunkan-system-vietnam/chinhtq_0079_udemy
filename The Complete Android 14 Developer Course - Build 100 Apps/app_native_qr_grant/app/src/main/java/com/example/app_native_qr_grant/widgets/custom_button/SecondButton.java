package com.example.app_native_qr_grant.widgets.custom_button;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.DrawableContainer;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.StateListDrawable;
import android.util.AttributeSet;
import android.view.Gravity;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.databinding.BindingAdapter;

import com.example.app_native_qr_grant.R;

import java.util.Objects;

public class SecondButton extends AppCompatTextView {
    public SecondButton(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        setGravity(Gravity.CENTER);
        setBackgroundResource(R.drawable.button_background_second);
    }

    @BindingAdapter(value = {"android:background","setBorderWidth","setBorderColor","setRadius"},requireAll = false)
    public static void setBackground(@NonNull TextView view, Integer buttonBackground, Integer width, Integer borderColor, Float radius){
        if(buttonBackground == null){
            buttonBackground = Color.parseColor("#FFFFFFFF");
        }
        if(width == null){
            width = 4;
        }
        if(borderColor == null){
            borderColor = Color.parseColor("#FF2053A1");
        }
        if (radius == null){
            radius = 10F;
        }
        StateListDrawable stateListDrawable = (StateListDrawable) view.getBackground();
        DrawableContainer.DrawableContainerState drawableContainerState = (DrawableContainer.DrawableContainerState) stateListDrawable.getConstantState();
        Drawable[] children = Objects.requireNonNull(drawableContainerState).getChildren();
        for(int i =0; i < 4; i++){
            GradientDrawable result = (GradientDrawable) children[i];
            if(i != 3){
                String hex = Integer.toHexString(buttonBackground).substring(2);
                String newHex = "";
                if(hex.equals("ffffff")){
                    newHex = "#1A000000";
                }else {
                    newHex = "#B3"+hex;
                }
                result.setColor(Color.parseColor(newHex));
            }else {
                result.setColor(buttonBackground);
            }
            result.setStroke(width, borderColor);
            result.setCornerRadius(radius * Resources.getSystem().getDisplayMetrics().density);
        }
    }
}
