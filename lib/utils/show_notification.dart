import 'dart:isolate';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:med_reminder/utils/get_time_of_day.dart';
import 'package:med_reminder/utils/notification_id_by_time.dart';

@pragma('vm:entry-point')
void showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'med_reminder',
        'med_reminder',
        channelDescription: 'Med Reminder',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
        autoCancel: false,
        ongoing: true,
      );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await FlutterLocalNotificationsPlugin().show(
    getNotificationIdByTime(),
    'Did You Take Medicine?',
    'Please Take Your Medicine at ${getTimeOfDay()}.',
    platformChannelSpecifics,
  );
}
