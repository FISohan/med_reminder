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

/// Calculates the duration from the current time to the next time period
/// (morning, afternoon, evening, or the next morning).
///
/// The function determines the current hour and time of day, then calculates
/// the absolute difference in hours between the current time and the end hour
/// of the current time period. If the current time does not match any defined
/// time period, it defaults to calculating the duration until the start of the
/// morning period.
///
/// Returns:
///   A [Duration] object representing the time difference in hours.
Duration getDurationFromCurrentToNextTime(String from, String to) {
  int duration = 0;
  int startOffset = TIME_IN_ORDER.indexOf(from);
  while (true) {
    if (TIME_IN_ORDER[(startOffset + 1) % TIME_IN_ORDER.length] == to) break;
    duration += TIME_OFFSET[startOffset];
    startOffset++;
  }
  return Duration(hours: duration);
}
