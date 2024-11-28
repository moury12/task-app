import 'package:flutter/material.dart';

class TaskView extends StatefulWidget {
  static const String routeName = '/specific-task';
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
