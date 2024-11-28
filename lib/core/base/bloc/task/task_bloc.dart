import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management/core/base/model/task_model.dart';
import 'package:task_management/core/base/service/task_service.dart';
import 'package:task_management/core/utils/boxes.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<CreateTaskEvent>((event, emit) async {
      emit(TaskInitial());
      String? token = HiveBoxes.getUserData().get('token');
      if (token != null && token.isNotEmpty) {
        Map<String, dynamic> responseData = await TaskService.createTask(
            title: event.title, description: event.description, token: token);
        if (responseData['status'] != null &&
            responseData['status'] == 'Success') {
          emit(TaskCreatedState(message: responseData['message']));
        } else {
          emit(TaskErrorState(message: "Something Went wrong"));
        }
      } else {
        emit(TaskErrorState(message: "Provide valid token"));
      }
    });
    on<LoadAllTasks>((event, emit) async {
      try {
        emit(TaskInitial());
        String? token = HiveBoxes.getUserData().get('token');
        if (token != null && token.isNotEmpty) {
          List<TaskModel> taskList = await TaskService.getAllTask(token: token);
          emit(AllTaskLoadedState(taskList: taskList));
        } else {
          emit(TaskErrorState(message: 'Provide valid token'));
        }
      } catch (e) {
        emit(TaskErrorState(message: 'An error occurred: $e'));
      }
    });
    on<DeleteTaskEvent>((event, emit) async {
      try {
        emit(TaskInitial());
        String? token = HiveBoxes.getUserData().get('token');
        if (token != null && token.isNotEmpty) {
          Map<String, dynamic> responseData =
              await TaskService.deleteTask(token: token, taskId: event.taskId);
          if (responseData['status'] != null &&
              responseData['status'] == 'Success') {
            emit(TaskCreatedState(message: responseData['message']));
          } else {
            emit(TaskErrorState(message: "Something Went wrong"));
          }
        } else {
          emit(TaskErrorState(message: 'Provide valid token'));
        }
      } catch (e) {
        emit(TaskErrorState(message: 'An error occurred: $e'));
      }
    });
    on<FetchSpecificTask>((event, emit) async {
      try {
        emit(TaskInitial());
        String? token = HiveBoxes.getUserData().get('token');
        if (token != null && token.isNotEmpty) {
          Map<String, dynamic> responseData =
              await TaskService.fetchSpecificTask(
                  token: token, taskId: event.taskId);
          if (responseData['status'] != null &&
              responseData['status'] == 'Success') {
            TaskModel taskModel = TaskModel.fromJson(responseData['data']);

            emit(SpecificTaskLoadedState(task: taskModel));
          } else {
            emit(TaskErrorState(message: "Something Went wrong"));
          }
        } else {
          emit(TaskErrorState(message: 'Provide valid token'));
        }
      } catch (e) {
        emit(TaskErrorState(message: 'An error occurred: $e'));
      }
    });
  }
}
