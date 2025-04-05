import 'package:objectbox/objectbox.dart';

@Entity()
class Med {
  @Id()
  int? id;
  final String name;
  final String notes;
  final bool beforeMeal;
  final String? image;
  @Backlink()
  final ToMany<Dose> doses = ToMany<Dose>();
  Med({
    this.id = 0,
    required this.name,
    required this.notes,
    required this.image,
    required this.beforeMeal,
  });
}

@Entity()
class Dose {
  @Id()
  int id;
  final String time;
  final String quantity;
  final ToOne<Med> med = ToOne<Med>();
  Dose({this.id = 0, required this.time, required this.quantity});
}