package com.example.app_native_qr_grant.domain.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class DataResponseModel<T> {
    @SerializedName("option")
    @Expose
    private String option;
    @SerializedName("app_version")
    @Expose
    private String appVersion;
    @SerializedName("payload")
    @Expose
    private T payload;

    public String getOption() {
        return option;
    }

    public String getAppVersion() {
        return appVersion;
    }

    public T getPayload() {
        return payload;
    }
}
