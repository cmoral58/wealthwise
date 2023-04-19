import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wealthwise/views/add_task_view.dart';
import 'package:wealthwise/views/header_view.dart';
import 'package:wealthwise/views/task_list_view.dart';

class taskPage extends StatelessWidget {
  const taskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              //Header View
              Expanded(flex: 1, child: HeaderView()),

              //Task Info View
              Expanded(flex: 1, child: Container(color: Colors.green)),

              //Taslk List View
              Expanded(flex: 7, child: TaskListView()),
            ],
          ),
        ),
        floatingActionButton: const AddTaskView());
  }
}
