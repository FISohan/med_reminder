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

String getTimeOfDay() {
  final hour = TimeOfDay.now().hour;

  if (hour >= 5 && hour < 12) {
    return "Morning";
  } else if (hour >= 12 && hour < 17) {
    return "Afternoon";
  } else if (hour >= 17 && hour < 21) {
    return "Evening";
  } else {
    return "Night";
  }
}
