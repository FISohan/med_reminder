import 'package:med_reminder/utils/get_time_of_day.dart';

int getNotificationIdByTime() {
  Map<String, int> notificationId = {
    'Morning': 1,
    'Afternoon': 2,
    'Evening': 3,
    'Night': 4,
  };

  return notificationId[getTimeOfDay()]!;
}
