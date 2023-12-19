package com.example.app_native_qr_grant.widgets;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.media.Image;
import android.media.MediaPlayer;
import android.os.Build;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.camera.core.CameraSelector;
import androidx.camera.core.ImageAnalysis;
import androidx.camera.core.ImageCapture;
import androidx.camera.core.ImageProxy;
import androidx.camera.core.Preview;
import androidx.camera.lifecycle.ProcessCameraProvider;
import androidx.camera.view.PreviewView;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.example.app_native_qr_grant.R;
import com.google.common.util.concurrent.ListenableFuture;
import com.google.mlkit.vision.barcode.BarcodeScanner;
import com.google.mlkit.vision.barcode.BarcodeScannerOptions;
import com.google.mlkit.vision.barcode.BarcodeScanning;
import com.google.mlkit.vision.barcode.common.Barcode;
import com.google.mlkit.vision.common.InputImage;

import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class CameraPreview implements ImageAnalysis.Analyzer{
    public interface OnReader {
        void readerBarCodeData(List<Barcode> barcodes);
    }

    private final AppCompatActivity activity;
    public ListenableFuture cameraProviderFuture;
    private ExecutorService cameraExecutor;
    private final PreviewView previewView;
    private final CameraPreview.OnReader reader;
    public ProcessCameraProvider processCameraProvider;
    public MediaPlayer mediaPlayer;

    public CameraPreview(@NonNull AppCompatActivity activity, PreviewView previewView, CameraPreview.OnReader reader) {
        this.activity = activity;
        this.previewView = previewView;
        this.reader = reader;
        setupCamera();
    }

    private void setupCamera() {
        mediaPlayer = MediaPlayer.create(activity.getApplicationContext(), R.raw.beep);
        activity.getWindow().setFlags(1024, 1024);
        cameraExecutor = Executors.newSingleThreadExecutor();
        cameraProviderFuture = ProcessCameraProvider.getInstance(activity.getApplicationContext());
        cameraProviderFuture.addListener(() -> {
            if (ActivityCompat.checkSelfPermission(activity.getApplicationContext(), Manifest.permission.CAMERA) != (PackageManager.PERMISSION_GRANTED)) {
                ActivityCompat.requestPermissions(activity, new String[]{Manifest.permission.CAMERA}, 101);
            } else {
                startCamera();
            }
        }, ContextCompat.getMainExecutor(activity.getApplicationContext()));
    }

    public void bindPreview() {
        Preview preview = new Preview.Builder().build();
        CameraSelector cameraSelector = new CameraSelector.Builder().requireLensFacing(
                CameraSelector.LENS_FACING_BACK).build();
        preview.setSurfaceProvider(previewView.getSurfaceProvider());
        ImageCapture imageCapture = new ImageCapture.Builder().build();
//        ResolutionSelector resolutionSelector = new ResolutionSelector.Builder()
//                .setResolutionStrategy(new ResolutionStrategy(new Size(1280, 720), ResolutionStrategy.FALLBACK_RULE_CLOSEST_LOWER_THEN_HIGHER))
//                .build();
        ImageAnalysis imageAnalysis = new ImageAnalysis.Builder()
                .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                .build();
        imageAnalysis.setAnalyzer(cameraExecutor, this);
        processCameraProvider.unbindAll();
        processCameraProvider.bindToLifecycle(activity, cameraSelector, preview, imageCapture, imageAnalysis);
    }

    public void reinstallAppBar(@NonNull Appbar appbar) {
        int statusBarHeight = appbar.getStatusBarHeight();
        if (statusBarHeight == barHeightDefault()) {
            appbar.toolbar.setPadding(0, 0, 0, 0);
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            activity.getWindow().getAttributes().layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
        }
    }

    public void startCamera() {
        try {
            processCameraProvider = (ProcessCameraProvider) cameraProviderFuture.get();
            bindPreview();
        } catch (ExecutionException | InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    public void stopCamera() {
        processCameraProvider.unbindAll();
    }

    private int barHeightDefault() {
        DisplayMetrics metrics = Resources.getSystem().getDisplayMetrics();
        float px = 24 * (metrics.densityDpi / 160f);
        return Math.round(px);
    }

    @SuppressLint("UnsafeOptInUsageError")
    @Override
    public void analyze(@NonNull ImageProxy image) {
        Image image1 = image.getImage();
        assert image1 != null;
        InputImage inputImage = InputImage.fromMediaImage(image1, image.getImageInfo().getRotationDegrees());
        BarcodeScannerOptions scannerOptions = new BarcodeScannerOptions.Builder()
                .setBarcodeFormats(Barcode.FORMAT_QR_CODE).build();
        BarcodeScanner scanner = BarcodeScanning.getClient(scannerOptions);
        scanner.process(inputImage).addOnSuccessListener(reader::readerBarCodeData)
                .addOnFailureListener(e -> Log.e("Scan Fail", e + ""))
                .addOnCompleteListener(task -> image.close());
    }
}
