package com.scopro.flutter_plugin_scan

import android.app.Activity
import android.util.Log
import com.journeyapps.barcodescanner.BarcodeResult
import com.journeyapps.barcodescanner.CaptureManager
import com.journeyapps.barcodescanner.DecoratedBarcodeView

class CustomCaptureManager(private val activity: Activity, barcodeView: DecoratedBarcodeView) : CaptureManager(activity, barcodeView) {
    override fun returnResult(rawResult: BarcodeResult?) {
        super.returnResult(rawResult)
        Log.d("CustomCaptureManager", "returnResult: ${rawResult.toString()}")
        ResultDataManager.getInstance()!!.setBarCodeResult(rawResult!!)
        this.activity.finish();
    }
}