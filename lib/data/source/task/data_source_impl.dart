import 'dart:async';

import 'package:isar/isar.dart';
import 'package:test_tast/data/models/task_model.dart';
import 'package:test_tast/data/source/task/data_source.dart';

final class TaskDataSourceImpl implements TaskDataSource {
  final Isar _isar;

  const TaskDataSourceImpl(this._isar);

  @override
  FutureOr<void> create(String title, String text) async {
    final task = TaskModel()
      ..title = title
      ..text = text
      ..done = false
      ..createdAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.taskModels.put(task);
    });
  }

  @override
  FutureOr<TaskModel?> read(int id) => _isar.taskModels.get(id);

  @override
  FutureOr<Iterable<TaskModel>> readAll() =>
      _isar.taskModels.where().sortByCreatedAtDesc().findAll();

  @override
  FutureOr<void> update(
    int id, {
    String? title,
    String? text,
    bool? done,
  }) async {
    await _isar.writeTxn(() async {
      final task = await _isar.taskModels.get(id);

      if (task != null) {
        if (title != null) task.title = title;
        if (text != null) task.text = text;
        if (done != null) task.done = done;

        await _isar.taskModels.put(task);
      }
    });
  }
}
