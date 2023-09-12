package com.camerakit.flutter.sample.simple

import android.content.Intent
import android.view.View
import android.widget.Toast
import androidx.annotation.Nullable
import androidx.core.net.toFile
import com.snap.camerakit.support.app.CameraActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterFragmentActivity() {

    private val CAMERAKIT_GROUP_ID = "" //TODO fill group id here
    private val CAMERAKIT_API_TOKEN = "" //TODO fill api token here
    private val CHANNEL = "com.camerakit.flutter.sample.simple"

    private lateinit var _result: MethodChannel.Result
    private lateinit var _methodChannel: MethodChannel

    private val captureLauncher =
        (this as FlutterFragmentActivity).registerForActivityResult(CameraActivity.Capture) { captureResult ->
            when (captureResult) {
                is CameraActivity.Capture.Result.Success.Video -> {
                    _result.success(hashMapOf("path" to captureResult.uri.toFile().absolutePath.toString(),
                        "mime_type" to "video"))
                }
                is CameraActivity.Capture.Result.Success.Image -> {
                    _result.success(hashMapOf("path" to captureResult.uri.toFile().absolutePath.toString(),
                        "mime_type" to "image"))
                }
                is CameraActivity.Capture.Result.Cancelled -> {
                    Toast.makeText(this@MainActivity, "Action cancelled", Toast.LENGTH_SHORT).show()
                    _result.error("Cancelled", "Action Cancelled", null)
                }
                is CameraActivity.Capture.Result.Failure -> {
                    Toast.makeText(this@MainActivity, "Action failed", Toast.LENGTH_SHORT).show()
                    _result.error("Failure", "Action failed", null)
                }
            }
        }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        _methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        _methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "openCameraKitLenses") {
                _result = result
                captureLauncher.launch(
                    CameraActivity.Configuration.WithLenses(
                        cameraKitApiToken = CAMERAKIT_API_TOKEN,
                        lensGroupIds = arrayOf(CAMERAKIT_GROUP_ID)
                    )
                )
            } else {
                result.notImplemented()
            }
        }
    }
}
