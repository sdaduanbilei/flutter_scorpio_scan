package com.scopro.flutter_plugin_scan

import android.util.Log
import com.journeyapps.barcodescanner.BarcodeResult




class ResultDataManager {

    private var instance //恶汉模式，直z接先实例化
            : ResultDataManager? = null

    var barcodeResult: BarcodeResult? = null

    var callBack: ScanResultCallBack? = null
    private var TAG = "ResultDataManager"

    fun  setBarCodeResult(result: BarcodeResult){
        this.barcodeResult = result
        Log.d(TAG, "setBarCodeResult: ${barcodeResult} ${callBack}")
        callBack?.returnResultCallBackAction(result)
    }

    companion object{
        @Volatile private var instance //恶汉模式，直z接先实例化
                : ResultDataManager? = null
        fun getInstance(): ResultDataManager? { //同步控制,避免多线程的状况多创建了实例对象
            if (instance == null) {
                instance = ResultDataManager() //在需要的时候在创建
            }
            return instance
        }
    }


}

interface ScanResultCallBack {
    fun returnResultCallBackAction(rawResult: BarcodeResult?)
}