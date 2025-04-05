import 'package:med_reminder/data/med.dart';

abstract class IMedRepository {
  List<Med> getMeds();
  Future<Med> getMed(int id);
  int insertMed(Med med);
  Future<int> updateMed(Med med);
  Future<int> deleteMed(int id);
}