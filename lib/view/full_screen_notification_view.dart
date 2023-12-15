import 'package:alarm_app/services/notifications_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreenNotificationView extends StatelessWidget {
  FullScreenNotificationView({required this.notificationId, super.key});
  final int notificationId;

  final NotificationServices notificationServices = NotificationServices();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
              onPressed: () {
                notificationServices.cancelNotification(notificationId);
                SystemNavigator.pop();
              },
              child: const Text('Stop'),
            ),
          )),
    );
  }
}
