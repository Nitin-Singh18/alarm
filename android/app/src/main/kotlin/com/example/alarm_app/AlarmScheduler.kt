package com.example.alarm_app

import java.time.LocalDateTime

interface AlarmScheduler {
    fun schedule(item:LocalDateTime)
    fun cancel(item:LocalDateTime)
}