package com.example.app_native_qr_grant.infrastructure;

import androidx.lifecycle.MutableLiveData;

import com.example.app_native_qr_grant.domain.model.UserModel;
import com.example.app_native_qr_grant.widgets.CameraPreview;

public class Global {
    public static MutableLiveData<UserModel> userData = new MutableLiveData<>();
    public static Routes routes;
    public static MutableLiveData<Boolean> isLoading = new MutableLiveData<>(false);
    public static CameraPreview cameraPreview;
}
