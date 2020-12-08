package com.scopro.flutter_plugin_scan

import android.app.Activity
import android.os.Bundle
import android.view.KeyEvent
import android.widget.TextView
import com.journeyapps.barcodescanner.CaptureManager
import com.journeyapps.barcodescanner.DecoratedBarcodeView

class CustomScanActivity : Activity() {
    private lateinit var capture: CustomCaptureManager
    private lateinit var barcodescannerView: DecoratedBarcodeView


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_custom_scan)

        barcodescannerView = findViewById(R.id.zxing_barcode_scanner)
        capture = CustomCaptureManager(this,barcodescannerView)
        capture.decode()

        findViewById<TextView>(R.id.close).setOnClickListener {
            finish()
        }
    }

    override fun onResume() {
        super.onResume()
        capture.onResume()
    }

    override fun onPause() {
        super.onPause()
        capture.onPause()
    }

    override fun onDestroy() {
        super.onDestroy()
        capture.onDestroy()
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        capture.onSaveInstanceState(outState)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        capture.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        return barcodescannerView.onKeyDown(keyCode, event) || super.onKeyDown(keyCode, event)
    }
}