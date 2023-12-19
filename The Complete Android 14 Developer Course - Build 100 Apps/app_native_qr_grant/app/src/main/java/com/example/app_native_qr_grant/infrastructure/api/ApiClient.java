package com.example.app_native_qr_grant.infrastructure.api;

import static com.example.app_native_qr_grant.infrastructure.Config.API_KEY;
import static com.example.app_native_qr_grant.infrastructure.Config.BASE_URL;
import static com.example.app_native_qr_grant.infrastructure.Config.MSG_API_ERROR;
import static com.example.app_native_qr_grant.infrastructure.Config.VERSION;

import android.content.Context;
import android.util.Log;

import com.example.app_native_qr_grant.R;
import com.example.app_native_qr_grant.domain.ApiService;
import com.example.app_native_qr_grant.domain.model.ResponseModel;
import com.example.app_native_qr_grant.domain.model.UserModel;
import com.example.app_native_qr_grant.infrastructure.DataStorage;
import com.example.app_native_qr_grant.widgets.custom_dialog.DialogMessage;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import java.lang.reflect.Field;
import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

import okhttp3.Headers;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class ApiClient {
    public ApiService service;

    public ApiClient(Context context) {
        DataStorage storage = new DataStorage(context);
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .client(new OkHttpClient.Builder()
                        .addInterceptor(new HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY))
                        .addNetworkInterceptor(chain -> {
                            Request request = chain.request();
                            Headers headers = request.headers().newBuilder()
                                    .add("x-api-key", API_KEY)
                                    .add("Authorization", MessageFormat.format("Bearer {0}", storage.readString("token")))
                                    .add("mobile-id", storage.readString("mobile_id"))
                                    .add("user-agent", MessageFormat.format("android-{0}", VERSION)).build();
                            request = request.newBuilder().headers(headers).build();
                            Response response = chain.proceed(request);
                            ResponseBody result = response.peekBody(Long.MAX_VALUE);
                            Gson gson = new Gson();
                            ResponseModel data = gson.fromJson(result.toString(),ResponseModel.class);
                            Log.i("BODY", data.getMessage());
//                            if(response.code() != 200){
//                                new DialogMessage(context, R.color.red, MSG_API_ERROR, () -> {}).show();
//                            }
                            return response;
                        })
                        .readTimeout(10,TimeUnit.SECONDS)
                        .connectTimeout(10, TimeUnit.SECONDS)
                        .build())
                .build();
        service = retrofit.create(ApiService.class);
    }
}
