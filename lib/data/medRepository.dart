import 'package:med_reminder/data/IMedRepository.dart';
import 'package:med_reminder/data/med.dart';
import 'package:med_reminder/data/object_box_service.dart';

class Medrepository implements IMedRepository {
  final ObjectBoxService _objectBoxService;

  Medrepository({required ObjectBoxService objectBoxService})
    : _objectBoxService = objectBoxService;
  @override
  Future<int> deleteMed(int id) {
    // TODO: implement deleteMed
    throw UnimplementedError();
  }

  Future<Med> getMed(int id) {
    // TODO: implement getMed
    throw UnimplementedError();
  }

  @override
  List<Med> getMeds() {
    final meds = _objectBoxService.getAllMeds();
    return meds;
  }

  @override
  int insertMed(Med med) {
    final id = _objectBoxService.putNewMed(med);
    return id;
  }

  @override
  Future<int> updateMed(Med med) {
    // TODO: implement updateMed
    throw UnimplementedError();
  }
}
