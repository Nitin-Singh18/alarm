package com.example.alarm_app

import android.os.Bundle
import androidx.activity.ComponentActivity


class FullScreenActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        turnScreenOn()
    }
}