import 'package:flutter/material.dart';
import 'package:med_reminder/data/IMedRepository.dart';
import 'package:med_reminder/data/med.dart';
import 'package:med_reminder/utils/const.dart';
import 'package:med_reminder/utils/get_time_of_day.dart';
import 'package:med_reminder/utils/reminder_switch.dart';

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

  String getNextTime() {
    String currentTime = getTimeOfDay();
    int indexOfCurrentTime = TIME_IN_ORDER.indexOf(currentTime);
    String nextTime = "-1";
    for (int i = indexOfCurrentTime; i < TIME_IN_ORDER.length; i++) {
      if (_savedDoseTime.contains(TIME_IN_ORDER[i])) {
        nextTime = TIME_IN_ORDER[i];
        break;
      }
    }
    return nextTime;
  }

  void setRrminderState(bool value) {
    _reminderSwitch.setRemonderState(value);
    notifyListeners();
  }
}
