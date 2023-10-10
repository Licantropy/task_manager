import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_tast/data/models/task_model.dart';
import 'package:test_tast/data/source/task/data_source_impl.dart';
import 'package:test_tast/domain/task_repository.dart';
import 'package:test_tast/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  var isar = await Isar.open(
    [TaskModelSchema],
    directory: dir.path,
  );

  runApp(MyApp(
    repository: TaskRepository(
      TaskDataSourceImpl(isar),
    ),
  ));
}
