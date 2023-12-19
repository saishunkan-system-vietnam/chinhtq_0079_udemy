package com.example.app_native_qr_grant.application;

import static com.example.app_native_qr_grant.infrastructure.Global.isLoading;

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;

import java.util.Arrays;

public class LoginAccountProvider extends AndroidViewModel {
    public MutableLiveData<Boolean[]> validator = new MutableLiveData<>(new Boolean[]{true, true});

    public LoginAccountProvider(@NonNull Application application) {
        super(application);
    }


    public Boolean handleValidator(String inputMail, String inputPass){
        Boolean[] showError = {true,true};
        if(inputMail.equals("")){
            showError[0] = false;
        }
        if(inputPass.equals("")){
            showError[1] = false;
        }
        validator.setValue(new Boolean[]{showError[0],showError[1]});
        return Arrays.equals(showError, new Boolean[]{true, true});
    }

    public LiveData<Boolean[]> getValidator(){
        return validator;
    }
    public LiveData<Boolean> apiLoading(){
        return isLoading;
    }
}
