import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/core/base/bloc/auth/auth_bloc.dart';
import 'package:task_management/core/components/custom_button.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/utils/helper_function.dart';
import 'package:task_management/core/utils/paddings.dart';
import 'package:task_management/view/auth/registration_view.dart';
import 'package:task_management/view/home/home_view.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/login';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    super.dispose();
  }

  AuthBloc authBloc = AuthBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          log('Current state: $state');
          if (state is AuthSuccessState) {
            SnackbarService.showSnackbar(
              context: context,
              title: "Success",
              message: state.message,
            );
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          } else if (state is AuthErrorState) {
            SnackbarService.showSnackbar(
              context: context,
              title: "Error",
              message: state.message,
              isError: true,
            );
          }
        },
       child: Padding(
         padding: defaultPadding,
         child: Column(
           children: [
             CustomTextField(
               controller: emailLoginController,
               hintText: 'Enter Email',
             ),
             CustomTextField(
               controller: passwordLoginController,
               hintText: 'Enter password',
             ),
             CustomButton(
               title: 'Login',
               onPressed: () {
                 authBloc.add(AuthLoginEvent(
                     email: emailLoginController.text,
                     password: passwordLoginController.text));
               },
             ),
             TextButton(
                 onPressed: () {
                   Navigator.pushNamed(context, RegistrationView.routeName);
                 },
                 child: Text('Sign up'))
           ],
         ),
       ),
      ),
    );
  }
}
