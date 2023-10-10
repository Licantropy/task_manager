import 'package:flutter/material.dart';
import 'package:test_tast/domain/task_repository.dart';
import 'package:test_tast/presentation/providers/dependencies_provider.dart';
import 'package:test_tast/presentation/screens/task_list_screen.dart';

class MyApp extends StatelessWidget {
  final TaskRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return DependenciesProvider(
      taskRepository: repository,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TaskListScreen(),
      ),
    );
  }
}
