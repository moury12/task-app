import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/core/base/bloc/task/task_bloc.dart';
import 'package:task_management/core/components/custom_appbar.dart';
import 'package:task_management/core/components/custom_circular_progress.dart';
import 'package:task_management/core/constants/text_style_constant.dart';

class TaskView extends StatefulWidget {
  static const String routeName = '/specific-task';
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  TaskBloc taskBloc = TaskBloc();
  @override
  Widget build(BuildContext context) {
    final String taskId = ModalRoute.of(context)?.settings.arguments as String;
    log(taskId);
    taskBloc.add(FetchSpecificTask(taskId: taskId));
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<TaskBloc, TaskState>(
        bloc: taskBloc,
        builder: (context, state) {
          if (state is TaskInitial) {
            return DefaultCircularProgress();
          }
          if (state is SpecificTaskLoadedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text('Task Title: ${state.task.title ?? ''}',style: textStyle18BoldBlack,),
                  Text('Task description: ${state.task.description ?? ''}',style: textStyle16MediumBlack,),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
