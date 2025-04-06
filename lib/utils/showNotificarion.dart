import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void showNotification(String title, String body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'med_reminder',
        'med_reminder',
        channelDescription: 'Med Reminder',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await FlutterLocalNotificationsPlugin().show(
    0,
    title,
    body,
    platformChannelSpecifics,
  );
}
