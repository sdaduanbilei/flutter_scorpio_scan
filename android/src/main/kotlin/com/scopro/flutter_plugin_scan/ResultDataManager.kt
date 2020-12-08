package com.scopro.flutter_plugin_scan

import com.journeyapps.barcodescanner.BarcodeResult




class ResultDataManager {

    private var instance //恶汉模式，直接先实例化
            : ResultDataManager? = null

    var barcodeResult: BarcodeResult? = null

    var callBack: ScanResultCallBack? = null

    fun  setBarCodeResult(result: BarcodeResult){
        this.barcodeResult = result
        callBack?.returnResultCallBackAction(result)
    }

    @Synchronized
    fun getInstance(): ResultDataManager? {
        if (instance == null) {
            instance = ResultDataManager()
        }
        return instance
    }

}

interface ScanResultCallBack {
    fun returnResultCallBackAction(rawResult: BarcodeResult?)
}