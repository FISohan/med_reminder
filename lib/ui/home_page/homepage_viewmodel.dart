import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:med_reminder/data/IMedRepository.dart';
import 'package:med_reminder/data/med.dart';
import 'package:med_reminder/utils/const.dart';
import 'package:med_reminder/utils/get_time_of_day.dart';
import 'package:med_reminder/utils/reminder_switch.dart';
import 'package:med_reminder/utils/schedule_notification.dart';

class HomepageViewmodel extends ChangeNotifier {
  final IMedRepository _medRepository;
  final ReminderSwitch _reminderSwitch;

  HomepageViewmodel({
    required IMedRepository medRepository,
    required ReminderSwitch reminderSwitch,
  }) : _medRepository = medRepository,
       _reminderSwitch = reminderSwitch;

  List<Med> get meds => _medRepository.getMeds();
  List<Med> medsByTime = [];
  Set<String> _savedDoseTime = {};
  bool get isReminderOn => _reminderSwitch.getIsReminderOn();

  void addMed(Med med) {
    int id = _medRepository.insertMed(med);
    notifyListeners();
  }

  void getMedsByTime() {
    print("Getting meds by time");
    medsByTime = List.from(
      meds.where(
        (Med med) => med.doses.any((Dose dose) {
          _savedDoseTime.add(dose.time);
          return dose.time == getTimeOfDay();
        }),
      ),
    );
  }

  void setNotificationSchedule() {
    for (String time in _savedDoseTime) {
      switch (time) {
        case MORNING:
          scheduleNotification(hour: 7, minute: 0, alarmID: MORNING_ALARM_ID);
          break;
        case AFTERNOON:
          scheduleNotification(
            hour: 13,
            minute: 0,
            alarmID: AFTERNOON_ALARM_ID,
          );
          break;
        case EVENING:
          scheduleNotification(hour: 16, minute: 30, alarmID: EVENING_ALARM_ID);
          break;
        case NIGHT:
          scheduleNotification(hour: 20, minute: 0, alarmID: NIGHT_ALARM_ID);
          break;
      }
    }
  }

  void cancleNotificationSchedule() {
    for (String time in _savedDoseTime) {
      switch (time) {
        case MORNING:
          AndroidAlarmManager.cancel(MORNING_ALARM_ID);
          break;
        case AFTERNOON:
          AndroidAlarmManager.cancel(AFTERNOON_ALARM_ID);

          break;
        case EVENING:
          AndroidAlarmManager.cancel(EVENING_ALARM_ID);
          break;
        case NIGHT:
          AndroidAlarmManager.cancel(NIGHT_ALARM_ID);
          break;
      }
    }
  }

  void setRrminderState(bool value) {
    _reminderSwitch.setRemonderState(value);
    notifyListeners();
  }
}
