part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class AllTaskLoadedState extends TaskState {
  final List<TaskModel> taskList;

  AllTaskLoadedState({required this.taskList});
}

class TaskCreatedState extends TaskState {
  final String message;

  TaskCreatedState({required this.message});
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState({required this.message});
}
