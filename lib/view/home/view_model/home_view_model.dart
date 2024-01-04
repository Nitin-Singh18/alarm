import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, DateTime?>((ref) => HomeViewModel());

class HomeViewModel extends StateNotifier<DateTime?> {
  HomeViewModel() : super(null);

  void setAlarm(
      {required int hour,
      required int minute,
      required BuildContext context}) async {
    final currentTime = DateTime.now();
    final alarmTime = DateTime(
        currentTime.year, currentTime.month, currentTime.day, hour, minute);
    print(alarmTime);
    updateAlarmTime(alarmTime);
    await callNativeSetAlarm(hour, minute);
  }

  Future<void> callNativeSetAlarm(int hours, int minutes) async {
    try {
      final String? value = await channel
          .invokeMethod('setTime', {'hours': hours, 'minutes': minutes});
      print(value);
    } on PlatformException catch (e) {
      print("Error : $e");
    }
  }

  void updateAlarmTime(DateTime alarmTime) {
    state = alarmTime;
  }
}

const MethodChannel channel = MethodChannel("alarm_channel");
