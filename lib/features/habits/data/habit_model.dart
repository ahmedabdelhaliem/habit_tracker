import 'package:hive/hive.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class HabitModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int repetitions;

  @HiveField(2)
  String frequency;

  HabitModel({required this.name, required this.repetitions, required this.frequency});
}
