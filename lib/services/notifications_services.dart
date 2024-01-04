import 'dart:typed_data';
import 'package:alarm_app/const/const.dart';
import 'package:alarm_app/view/full_screen_notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('img');

  void initializeNotifications(BuildContext context) async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullScreenNotificationView(
                      notificationId: response.id!,
                    )));
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  void alarmNotification(
    String title,
    String body,
  ) async {
    //to repeat alarm
    const int insistentFlag = 4;
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("alarm", "alarm Channel",
            importance: Importance.high,
            priority: Priority.high,
            autoCancel: false,
            playSound: true,
            sound: const RawResourceAndroidNotificationSound('alarm'),
            fullScreenIntent: true,
            category: AndroidNotificationCategory.alarm,
            ongoing: true,
            audioAttributesUsage: AudioAttributesUsage.alarm,
            actions: [
              const AndroidNotificationAction(
                AppString.cancelNotificationActionId,
                'Stop',
              )
            ],
            additionalFlags: Int32List.fromList(<int>[insistentFlag]));

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails);
  }

  void cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}

//to handle the on tap of alarm notification
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  NotificationServices notificationServices = NotificationServices();

  //checking if the 'Stop' action is clicked to cancel the alarm notification
  if (response.actionId == AppString.cancelNotificationActionId &&
      response.id != null) {
    print('action called');
    notificationServices.cancelNotification(response.id!);
  }
}
