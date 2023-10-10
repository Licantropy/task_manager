import 'package:flutter/cupertino.dart';
import 'package:test_tast/domain/task_repository.dart';

class TaskScreenNotifier with ChangeNotifier {
  final TaskRepository _taskRepository;

  bool _done = false;

  bool _loading = false;

  bool get done => _done;

  bool get loading => _loading;

  TaskScreenNotifier(this._taskRepository);

  void addTask(String title, String text) async {
    _loading = true;
    notifyListeners();
    await _taskRepository.create(title, text);
    _loading = false;
    _done = true;
    notifyListeners();
  }

  void editTask(int id, String title, String text) async {
    _loading = true;
    notifyListeners();
    await _taskRepository.changeContent(id, title, text);
    _loading = false;
    _done = true;
    notifyListeners();
  }
}
