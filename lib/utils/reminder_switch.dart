import 'package:shared_preferences/shared_preferences.dart';

class ReminderSwitch {
  final SharedPreferences sharedPreferences;
  ReminderSwitch({required this.sharedPreferences}) {
    initReminderState();
  }
  bool _isReminderOn = false;

  bool getIsReminderOn() {
    return _isReminderOn;
  }

  void initReminderState() {
    _isReminderOn = sharedPreferences.getBool("is_reminder_on") ?? false;
  }

  void setRemonderState(bool value) {
    _isReminderOn = value;
    sharedPreferences.setBool("is_reminder_on", value);
  }
}
