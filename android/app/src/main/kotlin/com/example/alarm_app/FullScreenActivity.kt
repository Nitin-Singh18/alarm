package com.example.alarm_app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.BackHandler
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.Button
import androidx.compose.material.Text
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier



class FullScreenActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            Box(
                modifier = Modifier.fillMaxSize(),
                contentAlignment = Alignment.Center
            ) {
                BackHandler(enabled = true) {
                    finishAndRemoveTask()
                }
                Button(onClick = {
                    val notificationService = AlarmNotificationService(applicationContext)
                    notificationService.cancelAlarmNotification()
                    finishAndRemoveTask()
                }) {
                    Text(text = "Stop")
                }
            }
        }
        turnScreenOn()
    }
}