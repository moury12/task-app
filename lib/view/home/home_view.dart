import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/core/base/bloc/task/task_bloc.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/utils/boxes.dart';
import 'package:task_management/core/utils/helper_function.dart';
import 'package:task_management/view/auth/login_view.dart';
import 'package:task_management/view/task/task_view.dart';
import 'package:task_management/view/user-profile/user_profile_view.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/home';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TaskBloc taskBloc = TaskBloc();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    taskBloc.add(LoadAllTasks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, UserProfileView.routeName);
            },
            icon: Icon(Icons.account_box)),
        actions: [
          TextButton(
              onPressed: () {
                HiveBoxes.getUserData().delete('token');
                Navigator.pushReplacementNamed(context, LoginView.routeName);
              },
              child: Text('logout')),
        ],
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        bloc: taskBloc,
        listener: (context, state) {
          if (state is TaskCreatedState) {
            SnackbarService.showSnackbar(
                context: context, message: state.message);
            taskBloc.add(LoadAllTasks());
          }
          if (state is TaskErrorState) {
            SnackbarService.showSnackbar(
                context: context, message: state.message, isError: true);
            taskBloc.add(LoadAllTasks());
          }
        },
        builder: (context, state) {
          if (state is TaskInitial) {
            return CircularProgressIndicator();
          }
          if (state is AllTaskLoadedState) {
            return ListView.builder(
              itemCount: state.taskList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context,
                        TaskView.routeName, );
                  },
                  child: Row(
                    children: [
                      Text(state.taskList[index].title ?? ''),
                      IconButton(
                          onPressed: () {
                            taskBloc.add(DeleteTaskEvent(
                                taskId: state.taskList[index].sId ?? ''));
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  scrollable: true,
                  content: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          title: "Title",
                          hintText: "Enter title",
                          controller: titleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Title cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          title: "Description",
                          hintText: "Enter description",
                          controller: descriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Description cannot be empty";
                            }
                            return null;
                          },
                          isMultiline: true,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              taskBloc.add(CreateTaskEvent(
                                  title: titleController.text,
                                  description: descriptionController.text));
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Submit"),
                        ),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
