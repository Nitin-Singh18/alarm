package com.example.alarm_app

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.BackHandler
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
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
                Column (modifier = Modifier.fillMaxSize(),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
                ){
                    Button(onClick = {
                        launch(applicationContext)
                    }) {
                        Text(text = "Open App")
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
        }
        turnScreenOn()
    }

    private fun launch(context: Context){
        val intent = Intent(context,MainActivity::class.java )
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        intent.putExtra("navigateTo", true)
        context.startActivity(intent)
    }


}