import 'dart:async';

import 'package:test_tast/data/models/task_model.dart';
import 'package:test_tast/data/source/task/data_source.dart';

class TaskRepository {
  final TaskDataSource _dataSource;

  const TaskRepository(this._dataSource);

  FutureOr<Iterable<TaskModel>> getAllTasks() => _dataSource.readAll();

  FutureOr<TaskModel?> getTask(int id) => _dataSource.read(id);

  FutureOr<void> changeDone(int id, bool done) => _dataSource.update(
        id,
        done: done,
      );

  FutureOr<void> changeContent(int id, String title, String text) =>
      _dataSource.update(id, title: title, text: text);

  FutureOr<void> create(String title, String text) =>
      _dataSource.create(title, text);
}
