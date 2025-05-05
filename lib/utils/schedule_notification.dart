import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:med_reminder/utils/show_notification.dart';

void scheduleNotification({
  required int hour,
  required int minute,
  required int alarmID,
}) {
  DateTime now = DateTime.now();
  DateTime firstTrigger = DateTime(now.year, now.month, now.day, hour, minute);
  if (now.isBefore(firstTrigger)) {
    firstTrigger.add(Duration(days: 1));  
  }
  Duration alarmDuration = firstTrigger.difference(now);

  AndroidAlarmManager.periodic(
    alarmDuration,
    alarmID,
    showNotification,
    startAt: now.add(alarmDuration),
    wakeup: true,
    rescheduleOnReboot: true,
    exact: true,
  );
}
