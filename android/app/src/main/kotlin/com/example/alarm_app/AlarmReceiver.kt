package com.example.alarm_app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class AlarmReceiver : BroadcastReceiver(){
    override fun onReceive(context: Context?, intent: Intent?) {
        val alarmTime = intent?.getStringExtra("Alarm") ?: return
        context?.let {
            val service = AlarmNotificationService(context)
            service.showNotification()
            println("Alarm triggered : $alarmTime")
        }
    }
}