package com.scopro.flutter_plugin_scan

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.*
import android.provider.CalendarContract
import android.util.AttributeSet
import android.util.TypedValue
import com.journeyapps.barcodescanner.ViewfinderView


class CustomViewfinderView(context: Context, attrs: AttributeSet) : ViewfinderView(context, attrs) {
    /**
     * 扫描线起始位置
     */
    var mScanLinePosition = 0f

    /**
     * 扫描线厚度
     */
    var mScanLineDepth = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, 4f, resources.displayMetrics)

    /**
     * 扫描线每次重绘的移动距离
     */
    var mScanLineDy = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, 3f, resources.displayMetrics)

    /**
     * 线性梯度
     */
    var mLinearGradient: LinearGradient? = null

    /**
     * 线性梯度位置
     */
    var mPositions = floatArrayOf(0f, 0.5f, 1f)

    /**
     * 线性梯度各个位置对应的颜色值
     */
    var mScanLineColor = intArrayOf(0x343434, Color.WHITE, 0x00343434)
    @SuppressLint("DrawAllocation")
    override fun onDraw(canvas: Canvas) {
        refreshSizes()
        if (framingRect == null || previewFramingRect == null) {
            return
        }
        val frame: Rect = framingRect
        // 绘制扫描线
        mScanLinePosition += mScanLineDy.toInt()
        if (mScanLinePosition > frame.height()) {
            mScanLinePosition = 0f
        }
        mLinearGradient = LinearGradient(frame.left.toFloat(), frame.top.toFloat() + mScanLinePosition, frame.right.toFloat(), frame.top + mScanLinePosition, mScanLineColor, mPositions, Shader.TileMode.REPEAT)
        paint.shader = mLinearGradient
        paint.color = Color.RED
        canvas.drawRect(frame.left.toFloat(), frame.top.toFloat() + mScanLinePosition, frame.right.toFloat(), frame.top + mScanLinePosition + mScanLineDepth, paint)
        postInvalidateDelayed(CUSTOME_ANIMATION_DELAY,
                frame.left,
                frame.top,
                frame.right,
                frame.bottom)
    }

    companion object {
        /**
         * 重绘时间间隔
         */
        const val CUSTOME_ANIMATION_DELAY: Long = 12
    }
}