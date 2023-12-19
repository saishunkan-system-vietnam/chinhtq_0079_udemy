package com.example.app_native_qr_grant.domain;

import com.example.app_native_qr_grant.domain.model.DataResponseModel;
import com.example.app_native_qr_grant.domain.model.ResponseModel;
import com.example.app_native_qr_grant.domain.model.UserModel;

import java.util.HashMap;
import java.util.Map;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;

public interface ApiService {
    @POST("sc/shop/login")
    Call<DataResponseModel<UserModel>> loginService(@Body Map<String, Object> data);
    @POST("{tenantid}/shop/get-mobile-id")
    Call<DataResponseModel<HashMap<String, String>>> mobileIDService(@Path("tenantid") String tenantid, @Body Map<String, String> data);
    @GET("{tenantid}/shop/checklogin")
    Call<DataResponseModel<UserModel>> checkLoginService(@Path("tenantid") String tenantid);
}
