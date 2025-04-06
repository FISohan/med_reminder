/// A utility function that determines the time of day (Morning, Afternoon, Evening, or Night)
/// based on the current hour.
///
/// The function uses the current system time to determine the time of day:
/// - "Morning" for hours between 5 AM (inclusive) and 12 PM (exclusive).
/// - "Afternoon" for hours between 12 PM (inclusive) and 5 PM (exclusive).
/// - "Evening" for hours between 5 PM (inclusive) and 9 PM (exclusive).
/// - "Night" for all other hours.
///
/// Returns:
///   A [String] representing the time of day.
import 'package:flutter/material.dart';
import 'package:med_reminder/utils/const.dart';

String getTimeOfDay() {
  final hour = TimeOfDay.now().hour;

  if (hour >= MORNING_START_HOUR && hour < MORNING_END_HOUR) {
    return MORNING;
  } else if (MORNING_END_HOUR >= 12 && hour < AFTERNOON_END_HOUR) {
    return AFTERNOON;
  } else if (AFTERNOON_END_HOUR >= 17 && hour < EVENING_END_HOUR) {
    return EVENING;
  } else {
    return NIGHT;
  }
}

Duration getDurationFromCurrentToNextTime() {
  final int currentHour = TimeOfDay.now().hour;
  final String currentTime = getTimeOfDay();
  switch (currentTime) {
    case MORNING:
      return Duration(hours: (MORNING_END_HOUR - currentHour).abs());
    case AFTERNOON:
      return Duration(hours: (AFTERNOON_END_HOUR - currentHour).abs());
    case EVENING:
      return Duration(hours: (EVENING_END_HOUR - currentHour).abs());
    default:
      return Duration(hours: (MORNING_START_HOUR - currentHour).abs());
  }
}
