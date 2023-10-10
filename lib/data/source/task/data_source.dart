import 'dart:async';

import 'package:test_tast/data/models/task_model.dart';

abstract interface class TaskDataSource {
  FutureOr<Iterable<TaskModel>> readAll();

  FutureOr<void> create(String title, String text);

  FutureOr<void> update(int id, {String? title, String? text, bool? done});

  FutureOr<TaskModel?> read(int id);
}