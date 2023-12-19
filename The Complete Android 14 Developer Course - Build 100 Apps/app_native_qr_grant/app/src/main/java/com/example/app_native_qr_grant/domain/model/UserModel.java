package com.example.app_native_qr_grant.domain.model;

import androidx.databinding.BaseObservable;
import androidx.databinding.Bindable;
import androidx.databinding.library.baseAdapters.BR;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class UserModel extends BaseObservable {
    @SerializedName("shop_code")
    @Expose
    private String shopCode;
    @SerializedName("shop_name")
    @Expose
    private String shopName;
    @SerializedName("mail")
    @Expose
    private String mail;
    @SerializedName("login_qrcode")
    @Expose
    private String loginQrcode;
    @SerializedName("status")
    @Expose
    private String status;
    @SerializedName("token")
    @Expose
    private String token;
    @SerializedName("is_mailable")
    @Expose
    private int isMailable;
    @SerializedName("tenantid")
    @Expose
    private String tenantid;
    @SerializedName("pattern")
    @Expose
    private String pattern;
    @SerializedName("event_name")
    @Expose
    private String eventName;
    @SerializedName("city_name")
    @Expose
    String cityName;

    public UserModel(String cityName) {
        this.cityName = cityName;
    }

    @Bindable
    public String getShopCode() {
        return shopCode;
    }

    public void setShopCode(String shopCode) {
        this.shopCode = shopCode;
        notifyPropertyChanged(BR.shopCode);
    }

    @Bindable
    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
        notifyPropertyChanged(BR.shopName);
    }

    @Bindable
    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
        notifyPropertyChanged(BR.mail);
    }

    @Bindable
    public String getLoginQrcode() {
        return loginQrcode;
    }

    public void setLoginQrcode(String loginQrcode) {
        this.loginQrcode = loginQrcode;
        notifyPropertyChanged(BR.loginQrcode);
    }

    @Bindable
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
        notifyPropertyChanged(BR.status);
    }

    @Bindable
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
        notifyPropertyChanged(BR.token);
    }

    @Bindable
    public int getIsMailable() {
        return isMailable;
    }

    public void setIsMailable(int isMailable) {
        this.isMailable = isMailable;
        notifyPropertyChanged(BR.isMailable);
    }

    @Bindable
    public String getTenantid() {
        return tenantid;
    }

    public void setTenantid(String tenantid) {
        this.tenantid = tenantid;
        notifyPropertyChanged(BR.tenantid);
    }

    @Bindable
    public String getPattern() {
        return pattern;
    }

    public void setPattern(String pattern) {
        this.pattern = pattern;
        notifyPropertyChanged(BR.pattern);
    }

    @Bindable
    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
        notifyPropertyChanged(BR.eventName);
    }

    @Bindable
    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
        notifyPropertyChanged(BR.cityName);
    }
}
