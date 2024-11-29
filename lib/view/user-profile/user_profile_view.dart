import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management/core/base/bloc/user/user_bloc.dart';
import 'package:task_management/core/components/custom_appbar.dart';
import 'package:task_management/core/components/custom_button.dart';
import 'package:task_management/core/components/custom_circular_progress.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/constants/image_constant.dart';
import 'package:task_management/core/constants/text_style_constant.dart';
import 'package:task_management/core/init/api_client.dart';
import 'package:task_management/core/utils/helper_function.dart';
import 'package:task_management/core/utils/sizedboxes.dart';
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
        appBar: CustomAppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditProfileView.routeName);
                },
                child: const Text('Edit profile'))
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
              context.read<UserBloc>().add(UserLoadedEvent());
            }
          },
          builder: (BuildContext context, UserState state) {
            if (state is UserInitial) {
              return const DefaultCircularProgress();
            } else if (state is UserLoadedState) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                            height: 150,
                            width: 150,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: Image.network(
                              '${ApiClient.baseUrl}/${state.user.image ?? ' '}',
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(placeHolderImg),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  // Image has loaded
                                  return child;
                                }
                                // Show a progress indicator while loading
                                return DefaultCircularProgress();
                              },
                            )),
                        state.user.isVerified == 'true'
                            ? Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(Icons.verified,
                                    color: Colors.blue, size: 30.sp))
                            : const SizedBox.shrink()
                      ],
                    ),
                    state.user.isVerified == 'false'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'your account not verified yet!!',
                              ),
                              TextButton(
                                child: const Text('Verify'),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      scrollable: true,
                                      content: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                    'Your Activation code is '),
                                                Text(
                                                  '${state.user.activationCode ?? ''}',
                                                  style:
                                                      textStyle16SemiBoldBlack,
                                                ),
                                              ],
                                            ),
                                            spaceH8,
                                            CustomTextFormField(
                                              title: "email",
                                              hintText: "Enter email",
                                              controller: emailController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Title cannot be empty";
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                            CustomTextFormField(
                                              title: "Activation Code",
                                              hintText: "Enter Activation Code",
                                              controller:
                                                  activationCodeController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
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
                                                          email: emailController
                                                              .text,
                                                          code:
                                                              activationCodeController
                                                                  .text));

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
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    Text(
                      '${state.user.firstName ?? ''} ${state.user.lastName ?? ''}',
                      style: textStyle18BoldBlack,
                    ),
                    Text(state.user.email ?? ''),
                    Text(state.user.address ?? ''),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
