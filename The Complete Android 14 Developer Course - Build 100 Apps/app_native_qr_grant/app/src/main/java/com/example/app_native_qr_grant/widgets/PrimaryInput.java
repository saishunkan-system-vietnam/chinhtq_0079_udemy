package com.example.app_native_qr_grant.widgets;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.DrawableContainer;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.StateListDrawable;
import android.os.Build;
import android.text.InputType;
import android.text.method.HideReturnsTransformationMethod;
import android.text.method.PasswordTransformationMethod;
import android.text.method.SingleLineTransformationMethod;
import android.util.AttributeSet;
import android.view.inputmethod.EditorInfo;
import android.widget.EditText;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatEditText;
import androidx.databinding.BindingAdapter;

import com.example.app_native_qr_grant.R;
import com.google.android.material.textfield.TextInputEditText;

import java.util.Objects;

public class PrimaryInput extends TextInputEditText {
    public PrimaryInput(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        setBackgroundResource(R.drawable.custom_focus_input);
        setCompoundDrawablePadding((int) (10 * Resources.getSystem().getDisplayMetrics().density));
        setIncludeFontPadding(true);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            setImportantForAutofill(IMPORTANT_FOR_AUTOFILL_NO);
        }
        setPadding((int)(20 * Resources.getSystem().getDisplayMetrics().density),0,0,0);
        setHintTextColor(Color.parseColor("#FFA1A1A1"));
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            setTextCursorDrawable(R.drawable.custom_cursor_input);
        }

    }

    @BindingAdapter(value = {"validator","setRadius"}, requireAll = false)
    public static void setBackground(@NonNull EditText view, Boolean validator,Float radius){
        if(radius == null){
            radius = 30F;
        }
        StateListDrawable stateListDrawable = (StateListDrawable) view.getBackground();
        DrawableContainer.DrawableContainerState drawableContainerState = (DrawableContainer.DrawableContainerState) stateListDrawable.getConstantState();
        Drawable[] children = Objects.requireNonNull(drawableContainerState).getChildren();
        GradientDrawable borderDefault = (GradientDrawable) children[1];
        GradientDrawable borderFocus = (GradientDrawable) children[0];
        if(validator != null){
            if(validator){
                borderDefault.setStroke(4,Color.parseColor("#FFC8C8C8"));
                borderFocus.setStroke(4,Color.parseColor("#FF247DEA"));
            }else {
                borderDefault.setStroke(4,Color.parseColor("#FFEB4646"));
                borderFocus.setStroke(4,Color.parseColor("#FFEB4646"));
            }
        }
        borderDefault.setCornerRadius(radius * Resources.getSystem().getDisplayMetrics().density);
        borderFocus.setCornerRadius(radius * Resources.getSystem().getDisplayMetrics().density);
    }
}
