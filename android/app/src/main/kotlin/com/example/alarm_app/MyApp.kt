package com.example.alarm_app

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build

class MyApp : Application() {
    override fun onCreate() {
        createNotificationChannel()
        super.onCreate()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                AlarmNotificationService.ALARM_CHANNEL_ID,
                "Alarm",
                NotificationManager.IMPORTANCE_HIGH
            )
            channel.description = "Ringing"

            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }
}