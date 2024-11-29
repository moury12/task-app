import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management/core/base/bloc/auth/auth_bloc.dart';
import 'package:task_management/core/components/custom_button.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/constants/image_constant.dart';
import 'package:task_management/core/constants/text_style_constant.dart';
import 'package:task_management/core/utils/helper_function.dart';
import 'package:task_management/core/utils/paddings.dart';
import 'package:task_management/core/utils/sizedboxes.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
         child: Form(
           key: _formKey,
           child: SingleChildScrollView(
             child: Column(
             
               children: [
                 SizedBox(height: MediaQuery.of(context).viewPadding.top,),
                 Image.asset(loginImg,height: 200.w,),
                 spaceH8,
                 Text('Welcome Back! Glad to see you, again!',style: textStyle20BoldBlack,),
                 spaceH8,
                 spaceH8,
                 CustomTextFormField(
                   controller: emailLoginController,
                   title: 'Email',
                   hintText: 'Enter your email',
                   keyboardType: TextInputType.emailAddress,
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter a valid email';
                     }
                     return null;
                   },
                 ),
                 spaceH8,
                 CustomTextFormField(
                   controller: passwordLoginController,
                   title: 'Password',
                   hintText: 'Enter your password',
                   isPassword: true,
                   validator: (value) {
                     if (value == null || value.length < 6) {
                       return 'Password must be at least 6 characters';
                     }
                     return null;
                   },
                 ),
                 spaceH8,
                 spaceH8,
                 CustomButton(
                   title: 'Login',
                   onPressed: () {
                     if (_formKey.currentState!.validate()){
                       authBloc.add(AuthLoginEvent(
                           email: emailLoginController.text,
                           password: passwordLoginController.text));
                     }
                   },
                 ),
                 Row(
                   children: [
                     const Text('New Here?'),
                     TextButton(
                         onPressed: () {
                           Navigator.pushNamed(context, RegistrationView.routeName);
                         },
                         child: const Text('Sign up')),
                   ],
                 )
               ],
             ),
           ),
         ),
       ),
      ),
    );
  }
  void clearControllers(){
    emailLoginController.clear();
    passwordLoginController.clear();

  }

}
