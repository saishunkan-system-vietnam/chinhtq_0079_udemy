package com.example.app_native_qr_grant.application;

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;

import java.util.ArrayList;
import java.util.List;

public class ApplyScanProvider extends AndroidViewModel {
    public List<String> listCoupon = new ArrayList<>();
    public MutableLiveData<String> count = new MutableLiveData<>();

    public ApplyScanProvider(@NonNull Application application) {
        super(application);
    }
    public LiveData<String> getCount(){
        return count;
    }
}
