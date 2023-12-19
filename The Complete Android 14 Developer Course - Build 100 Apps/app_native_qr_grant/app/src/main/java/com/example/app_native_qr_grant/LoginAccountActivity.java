package com.example.app_native_qr_grant;

import static com.example.app_native_qr_grant.infrastructure.Global.routes;
import static com.example.app_native_qr_grant.infrastructure.Global.userData;

import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.databinding.DataBindingUtil;
import androidx.lifecycle.ViewModelProvider;

import com.example.app_native_qr_grant.application.LoginAccountProvider;
import com.example.app_native_qr_grant.databinding.ActivityLoginAccountBinding;
import com.example.app_native_qr_grant.domain.DataCallbacks;
import com.example.app_native_qr_grant.domain.model.ResponseModel;
import com.example.app_native_qr_grant.domain.model.UserModel;
import com.example.app_native_qr_grant.infrastructure.DataStorage;
import com.example.app_native_qr_grant.infrastructure.api.impl.ApiRepository;
import com.example.app_native_qr_grant.widgets.Appbar;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

public class LoginAccountActivity extends Appbar {
    private ActivityLoginAccountBinding binding;
    private LoginAccountProvider provider;
    private ApiRepository api;
    private DataStorage storage;

    @Override
    public void init() {
        super.init();
        binding = DataBindingUtil.setContentView(this, R.layout.activity_login_account);
        provider = new ViewModelProvider(this).get(LoginAccountProvider.class);
        api = new ApiRepository(this);
        storage = new DataStorage(this);
        setupAppBar();
        provider.getValidator().observe(this, value -> {
            if (!value[0]) {
                binding.txtErrorMail.setText("メールアドレスを入力してください");
            }
            if (!value[1]) {
                binding.txtErrorPass.setText("パスワードを入力してください");
            }
            binding.setIsError(Arrays.asList(value));
        });
        provider.apiLoading().observe(this, value -> {
            binding.setIsLoading(value);
        });
    }

    @Override
    protected void onStart() {
        super.onStart();
        setTitleToolbar("ログイン");
        binding.activityLoginAccount.setOnClickListener(v -> {
            handleUnFocus(binding.edtEmail);
            handleUnFocus(binding.edtPass);
        });
        toolbar.setOnClickListener(v -> {
            handleUnFocus(binding.edtEmail);
            handleUnFocus(binding.edtPass);
        });
        binding.txtSubmit.setOnClickListener(v -> {
            String mail = Objects.requireNonNull(binding.edtEmail.getText()).toString();
            String pass = Objects.requireNonNull(binding.edtPass.getText()).toString();
            if (!provider.handleValidator(mail, pass)) return;
            storage.writeString("tenant_id", "miyagi");
            storage.writeString("token", "chinhtao1908@nguyenthao0706");
            routes.pushOffAll(HomeActivity.class);
//            api.loginAccount(mail, pass, data -> {
//                userData.setValue(data.getPayload());
//                storage.writeString("tenant_id", data.getPayload().getTenantid());
//                storage.writeString("token", data.getPayload().getToken());
//                api.mobileID(data1 -> {
//                    storage.writeString("mobile_id",data1);
//                });
//                routes.pushOffAll(HomeActivity.class);
//            });
        });
        binding.txtChangeScan.setOnClickListener(v -> routes.pushOff(LoginScanActivity.class));
    }
}