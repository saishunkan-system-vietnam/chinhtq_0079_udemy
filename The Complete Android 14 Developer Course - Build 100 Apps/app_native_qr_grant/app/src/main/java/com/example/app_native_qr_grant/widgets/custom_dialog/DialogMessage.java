package com.example.app_native_qr_grant.widgets.custom_dialog;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.databinding.DataBindingUtil;

import com.example.app_native_qr_grant.R;
import com.example.app_native_qr_grant.databinding.DialogShowMessageBinding;

import java.util.Objects;

public class DialogMessage extends Dialog {
    public interface OnListener{
        void onTap();
    }
    private final Integer color;
    private final String message;

    public DialogMessage(@NonNull Context context, Integer color, String message, OnListener listener) {
        super(context, R.style.Full_Screen_Dialog);
        setCanceledOnTouchOutside(false);
        setCancelable(false);
        this.color = color;
        this.message = message;
        this.listener = listener;
    }

    private final DialogMessage.OnListener listener;

    private DialogShowMessageBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = DataBindingUtil.inflate(LayoutInflater.from(getContext()), R.layout.dialog_show_message, null,false);
        setContentView(binding.getRoot());
        Objects.requireNonNull(getWindow()).setLayout(ViewGroup.LayoutParams.MATCH_PARENT,ViewGroup.LayoutParams.WRAP_CONTENT);
        binding.setColorBackground(color);
        binding.setColorBorder(R.color.white);
        binding.setRadius(5F);
        binding.txtMessageServer.setText(message);
        binding.btnDismiss.setOnClickListener(v->{
            listener.onTap();
            this.dismiss();
        });
    }
}
