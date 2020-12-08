package com.scopro.flutter_plugin_scan

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.google.zxing.integration.android.IntentIntegrator


class ScanActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_scan)
        findViewById<Button>(R.id.btnScan).setOnClickListener {

        }


    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        // 获取解析结果
        val result = IntentIntegrator.parseActivityResult(requestCode, resultCode, data)
        if (result != null) {
            if (result.contents == null) {
                Toast.makeText(this, "取消扫描", Toast.LENGTH_LONG).show()
            } else {
                Toast.makeText(this, "扫描内容:" + result.contents, Toast.LENGTH_LONG).show()
            }
        } else {
            super.onActivityResult(requestCode, resultCode, data)
        }
    }
}