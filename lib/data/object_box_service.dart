import 'package:med_reminder/data/med.dart';
import 'package:med_reminder/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ObjectBoxService {
  late final Store _store;
  late final Box<Med> box;

  ObjectBoxService._create(this._store){
    box = _store.box<Med>();
  }

  int putNewMed(Med med){
   return box.put(med);
  }

  List<Med> getAllMeds(){
    return box.getAll();
  }

  static Future<ObjectBoxService> create() async {
   final docsDir = await getApplicationDocumentsDirectory();
   final store = await openStore(directory:path.join(docsDir.path, 'objectbox'));
   return ObjectBoxService._create(store);
  }
}