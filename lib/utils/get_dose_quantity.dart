import 'package:med_reminder/data/med.dart';
import 'package:med_reminder/utils/get_time_of_day.dart';

/// Retrieves the dose quantity for a specific medication based on the current time of day.
///
/// This function iterates through the list of doses associated with the given [med]
/// and checks if the time of a dose matches the current time of day. If a match is found,
/// it returns the corresponding dose quantity. If no match is found, an empty string is returned.
///
/// - Parameter [med]: The medication object containing a list of doses.
/// - Returns: A string representing the dose quantity for the current time of day, 
///   or an empty string if no matching dose is found.
String getDoseQuantityByTime(Med med) {
  String doseQuantity = '-';
  for (var dose in med.doses) {
    if (dose.time == getTimeOfDay()) {
      doseQuantity = dose.quantity;
      print("Dose quantity: $doseQuantity");
    }
  }
  return doseQuantity;
}