import 'package:alarm_app/services/notifications_services.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
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
    // NotificationServices notificationServices = NotificationServices();
    // notificationServices.initializeNotifications(context);
    await AndroidAlarmManager.oneShotAt(alarmTime, 0, fireAlarm,
        alarmClock: true, wakeup: true);
  }

  void updateAlarmTime(DateTime alarmTime) {
    state = alarmTime;
  }
}

@pragma('vm:entry-point')
void fireAlarm() {
  print('Alarm ');
  NotificationServices notificationServices = NotificationServices();

  notificationServices.alarmNotification('Alarm', 'Ringing');
}
