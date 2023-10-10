import 'package:flutter/material.dart';
import 'package:test_tast/data/models/task_model.dart';
import 'package:test_tast/domain/task_repository.dart';

class TaskListNotifier with ChangeNotifier {
  final TaskRepository _repository;

  TaskListNotifier(this._repository);

  bool _loading = false;

  Iterable<TaskModel>? _tasks;

  bool get loading => _loading;

  Iterable<TaskModel> get tasks => _tasks ?? [];

  void fetch() async {
    _loading = true;
    notifyListeners();
    _tasks = await _repository.getAllTasks();
    _loading = false;
    notifyListeners();
  }

  void setDone(int id, bool done) async {
    await _repository.changeDone(id, done);
    fetch();
  }
}
