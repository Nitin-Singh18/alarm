import 'package:alarm_app/const/utils.dart';
import 'package:alarm_app/view/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, ref) {
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
          final TimeOfDay? value = await selectTime(context);
          if (value != null) {
            ref.read(homeViewModelProvider.notifier).setAlarm(
                hour: value.hour, minute: value.minute, context: context);
          }
        },
        child: const Icon(Icons.alarm_add),
      ),
    );
  }
}
