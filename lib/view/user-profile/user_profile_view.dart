import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/core/base/bloc/user/user_bloc.dart';
import 'package:task_management/core/components/custom_button.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/utils/helper_function.dart';
import 'package:task_management/view/user-profile/edit_profile_view.dart';

class UserProfileView extends StatefulWidget {
  static const String routeName = '/user-profile';

  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  void initState() {
    context.read<UserBloc>().add(UserLoadedEvent());
    super.initState();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController activationCodeController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditProfileView.routeName);
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserErrorState) {
              SnackbarService.showSnackbar(
                  context: context, message: state.message, isError: true);
            }
            if (state is UserSuccessState) {
              SnackbarService.showSnackbar(
                context: context,
                message: state.message,
              );
            }
          },
          builder: (BuildContext context, UserState state) {
            if (state is UserInitial) {
              return const CircularProgressIndicator();
            } else if (state is UserLoadedState) {
              return Column(
                children: [
// Image.network('${ApiClient.baseUrl}/${state.user.image??' '}'),
                  Text(state.user.email ?? ''),
                  Text(state.user.activationCode ?? ''),
                  Text(state.user.isVerified ?? ''),
                  state.user.isVerified == 'false'
                      ? CustomButton(
                          title: 'active',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      CustomTextFormField(
                                        title: "email",
                                        hintText: "Enter email",
                                        controller: emailController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Title cannot be empty";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      CustomTextFormField(
                                        title: "Activation Code",
                                        hintText: "Enter Activation Code",
                                        controller: activationCodeController,
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context.read<UserBloc>().add(
                                                ActiveUserEvent(
                                                    email: emailController.text,
                                                    code:
                                                        activationCodeController
                                                            .text));
                                            context
                                                .read<UserBloc>()
                                                .add(UserLoadedEvent());
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text("Submit"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const SizedBox.shrink()
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
