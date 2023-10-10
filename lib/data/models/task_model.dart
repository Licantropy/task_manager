import 'package:isar/isar.dart';

part 'task_model.g.dart';

@collection
class TaskModel {
  Id id = Isar.autoIncrement;

  String? title;

  String? text;

  bool? done;

  DateTime? createdAt;
}
