package com.scopro.flutter_plugin_scan

import android.app.Activity
import android.content.Context
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import com.google.zxing.integration.android.IntentIntegrator
import com.journeyapps.barcodescanner.BarcodeResult
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar





/** FlutterPluginScanPlugin */
class FlutterPluginScanPlugin: FlutterPlugin, MethodCallHandler,ActivityAware, ScanResultCallBack {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context : Context
  private lateinit var activity: Activity
  private var eventSink:EventChannel.EventSink? = null
  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding

  private var TAG = "FlutterPluginScanPlugin"



  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_plugin_scan")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
    EventChannel(flutterPluginBinding.binaryMessenger,"scan_event").setStreamHandler(
            object : EventChannel.StreamHandler{
              override fun onListen(arguments: Any?, events: EventSink) {
                eventSink = events ;
              }

              override fun onCancel(arguments: Any?) {
                eventSink = null
              }

            }
    )
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "startScan") {
      ResultDataManager.getInstance()!!.callBack = this;
      IntentIntegrator(activity)
              .setCaptureActivity(CustomScanActivity::class.java)
              .setPrompt(" ")
              .initiateScan()
      Log.d(TAG, "onMethodCall: ${eventSink}")
      result.success("Android ${Build.BOARD}")
    } else {
      result.notImplemented()
    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
  }

  override fun onDetachedFromActivity() {
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun returnResultCallBackAction(rawResult: BarcodeResult?) {
    Log.d(TAG, "returnResultCallBackAction: ${rawResult.toString()}")
     if (eventSink !=null){
       eventSink!!.success(rawResult.toString())
     } else {
       Log.d(TAG, "returnResultCallBackAction: ${eventSink} is null")
     }
  }
}
