import 'package:flutter/material.dart';
import 'package:test_tast/core/extensions/sized_box_extension.dart';
import 'package:test_tast/data/models/task_model.dart';
import 'package:test_tast/presentation/notifiers/task_screen_notifier.dart';
import 'package:test_tast/presentation/providers/dependencies_provider.dart';

class TaskScreen extends StatefulWidget {
  final TaskModel? taskModel;

  const TaskScreen({super.key, this.taskModel});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late final TextEditingController title;
  late final TextEditingController text;
  late final TaskScreenNotifier _taskScreenNotifier;

  @override
  void initState() {
    title = TextEditingController(text: widget.taskModel?.title);
    text = TextEditingController(text: widget.taskModel?.text);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _taskScreenNotifier = TaskScreenNotifier(
      DependenciesProvider.of(context).taskRepository,
    );

    _taskScreenNotifier.addListener(() {
      if (_taskScreenNotifier.done) {
        Navigator.of(context).pop();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _taskScreenNotifier,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              TextField(
                controller: title,
                decoration: const InputDecoration(labelText: 'title'),
              ),
              20.h,
              TextField(
                controller: text,
                decoration: const InputDecoration(labelText: 'text'),
              ),
              20.h,
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              widget.taskModel != null
                  ? _taskScreenNotifier.editTask(
                      widget.taskModel!.id, title.text, text.text)
                  : _taskScreenNotifier.addTask(title.text, text.text);
            },
            child: const Icon(Icons.done),
          ),
        );
      },
    );
  }
}
