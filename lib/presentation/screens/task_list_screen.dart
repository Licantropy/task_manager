import 'package:flutter/material.dart';
import 'package:test_tast/core/extensions/border_radius_extension.dart';
import 'package:test_tast/core/extensions/sized_box_extension.dart';
import 'package:test_tast/presentation/notifiers/task_list_notifier.dart';
import 'package:test_tast/presentation/providers/dependencies_provider.dart';
import 'package:test_tast/presentation/screens/task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late final TaskListNotifier notifier;

  @override
  void didChangeDependencies() {
    notifier = TaskListNotifier(
      DependenciesProvider.of(context).taskRepository,
    );

    notifier.fetch();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListenableBuilder(
          listenable: notifier,
          builder: (context, child) {
            if (notifier.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (notifier.tasks.isEmpty) {
              return const Center(
                child: Text('Пусто'),
              );
            }

            return ListView.separated(
              itemCount: notifier.tasks.length,
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final task = notifier.tasks.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => TaskScreen(
                              taskModel: task,
                            ),
                          ),
                        )
                        .whenComplete(
                          () => notifier.fetch(),
                        );
                  },
                  child: Material(
                    elevation: 10,
                    borderRadius: 10.r,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title!,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          20.h,
                          Text(task.text!),
                          20.h,
                          Text(task.createdAt.toString()),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Checkbox(
                              value: task.done,
                              onChanged: (bool? done) {
                                notifier.setDone(
                                  task.id,
                                  done!,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => 10.h,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const TaskScreen(),
                ),
              )
              .whenComplete(() => notifier.fetch());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
