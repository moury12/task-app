import 'package:flutter/material.dart';
import 'package:task_management/core/base/controller/auth_controller.dart';
import 'package:task_management/core/components/custom_button.dart';
import 'package:task_management/core/components/custom_text_field.dart';
import 'package:task_management/core/utils/paddings.dart';

class LoginView extends StatelessWidget {
  static const String routeName = '/login';
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: defaultPadding,
        child: Column(
          children: [
            CustomTextField(
              controller: AuthController.to.emailLoginController.value,
              hintText: 'Enter Email',
            ),
            CustomTextField(
              controller: AuthController.to.passwordLoginController.value,
              hintText: 'Enter password',
            ),
             CustomButton(
              title: 'Login',
              onPressed: () {
                AuthController.to.loginCall(email: AuthController.to.emailLoginController.value.text,
                    password: AuthController.to.passwordLoginController.value.text);
              },
            )
          ],
        ),
      ),
    );
  }
}
