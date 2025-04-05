import 'package:flutter/material.dart';
import 'package:med_reminder/data/IMedRepository.dart';
import 'package:med_reminder/data/med.dart';
import 'package:med_reminder/utils/get_time_of_day.dart';

class HomepageViewmodel extends ChangeNotifier {
  final IMedRepository _medRepository;
  HomepageViewmodel({required IMedRepository medRepository})
    : _medRepository = medRepository;

  List<Med> get meds => _medRepository.getMeds();
  List<Med> medsByTime = [];
  void addMed(Med med) {
    int id = _medRepository.insertMed(med);
    notifyListeners();
  }

  void getMedsByTime() {
    print("Getting meds by time");
    medsByTime = List.from(
        meds.where(
          (Med med) => med.doses.any((Dose dose) {
            return dose.time == getTimeOfDay();
          }),
        ));
    notifyListeners();
  }
}
