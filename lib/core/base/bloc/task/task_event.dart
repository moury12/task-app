part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}
class CreateTaskEvent extends TaskEvent{
  final String title;
  final String description;

  CreateTaskEvent({required this.title, required this.description});
}
class DeleteTaskEvent extends TaskEvent{
  final String taskId;


  DeleteTaskEvent({required this.taskId, });
}
class LoadAllTasks extends TaskEvent{

}