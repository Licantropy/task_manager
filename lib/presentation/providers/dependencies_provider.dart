import 'package:flutter/material.dart';
import 'package:test_tast/domain/task_repository.dart';

class DependenciesProvider extends InheritedWidget {
  final TaskRepository taskRepository;

  const DependenciesProvider({
    super.key,
    required this.taskRepository,
    required super.child,
  });

  static DependenciesProvider of(BuildContext context) {
    final DependenciesProvider? result =
        context.dependOnInheritedWidgetOfExactType<DependenciesProvider>();
    assert(result != null, 'No DependenciesProvider found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(DependenciesProvider oldWidget) {
    return taskRepository != oldWidget.taskRepository;
  }
}
