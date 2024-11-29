import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management/core/base/bloc/task/task_bloc.dart';
import 'package:task_management/core/components/custom_button.dart';
import 'package:task_management/core/components/custom_circular_progress.dart';
import 'package:task_management/core/components/custom_drawer.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/constants/image_constant.dart';
import 'package:task_management/core/constants/text_style_constant.dart';
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(


              content: Text(
                'Are you sure to close this app?',
                style: textStyle16MediumBlack,
              ),
              actions: [
               FloatingActionButton(onPressed:  () {
                 exit(0);
               },
                    child: const Text('Yes')),
                FloatingActionButton(onPressed:  () {
                  Navigator.pop(context);
                },
                    child: const Text('No'))
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(),
        drawer: const CustomDrawer(),
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
              return const DefaultCircularProgress();
            }
            if (state is AllTaskLoadedState) {
              return state.taskList.isEmpty?
                  Center(
                    child: Text('Task List is empty!!',style:  textStyle16MediumBlack,),
                  ): ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                itemCount: state.taskList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, TaskView.routeName,
                          arguments: state.taskList[index].sId);
                    },
                    child:Card(
                      child: ListTile(
                        title: Text(state.taskList[index].title ?? ''),
                      subtitle: Text(state.taskList[index].description ?? 'Description not provided') ,
                        trailing: IconButton(
                            onPressed: () {
                              taskBloc.add(DeleteTaskEvent(
                                  taskId: state.taskList[index].sId ?? ''));
                            },
                            icon: const Icon(Icons.delete,color: Colors.black,)),
                      ),
                    )
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Image.asset(
            addTaskImg,
            height: 40,
            width: 40,
          ),
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

                            isMultiline: true,
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                taskBloc.add(CreateTaskEvent(
                                    title: titleController.text,
                                    description: descriptionController.text));
                                clear();
                                Navigator.pop(context);
                              }
                            },
                            title: "Submit",
                          ),
                        ],
                      ),
                    ));
              },
            );
          },
        ),
      ),
    );
  }
  void clear(){
    titleController.clear();
    descriptionController.clear();
  }
}

