package com.example.alarm_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.time.LocalDateTime


class MainActivity : FlutterActivity() {
    private val channel = "alarm_channel"
    private val qrChannel = "qr_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        val scheduler = AndroidAlarmScheduler(context = this)
        super.configureFlutterEngine(flutterEngine)
        //to launch specific flutter screen
        val navigateTo = intent.getBooleanExtra("navigateTo", false)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, qrChannel).invokeMethod(
            "navigateTo", navigateTo,
        )
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler { call, result ->
                if (call.method == "setTime") {
                    val hours = call.argument<Int>("hours")
                    val minutes = call.argument<Int>("minutes")
                    if (hours != null && minutes != null) {
                        val currentDate = LocalDateTime.now()
                        val alarmTime = LocalDateTime.of(
                            currentDate.year,
                            currentDate.month,
                            currentDate.dayOfMonth,
                            hours,
                            minutes,
                        )
                        print(alarmTime)
                        scheduler.schedule(alarmTime)
                        result.success("Success $hours $minutes")
                    }

                } else {
                    result.notImplemented()
                }
            }
    }
}
