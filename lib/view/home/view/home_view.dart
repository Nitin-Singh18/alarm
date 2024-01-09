import 'package:alarm_app/const/utils.dart';
import 'package:alarm_app/view/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../qr/view/qr_scanner_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  void navigateTo(BuildContext context) {
    print("Navigating");
    qrChannel.setMethodCallHandler(
      (call) async {
        if (call.method == 'navigateTo') {
          final argument = call.arguments as bool;
          print("arguments : $argument");
          if (argument) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const QRScannerView()));
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    Future.delayed(const Duration(seconds: 1), () {
      navigateTo(context);
    });
    final alarmTime = ref.watch(homeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        height: 40,
        width: 390,
        alignment: Alignment.center,
        child: Text(
          alarmTime != null ? DateFormat.jm().format(alarmTime) : 'No alarm',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),

      // ListView.builder(
      //   itemCount: 1,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Container(
      //         width: 340,
      //         height: 40,
      //         alignment: Alignment.center,
      //         child: const Text(
      //           '12:00 am',
      //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      //         ));
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () async {
          // final TimeOfDay? value = await selectTime(context);
          final time = DateTime.now();
          final hours = time.hour;
          final minutes = time.minute + 1;

          print("$hours $time Set Time");
          // if (value != null) {
          ref
              .read(homeViewModelProvider.notifier)
              .setAlarm(hour: hours, minute: minutes, context: context);
          // }
        },
        child: const Icon(Icons.alarm_add),
      ),
    );
  }
}
