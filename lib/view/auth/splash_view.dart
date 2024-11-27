import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/view/auth/login_view.dart';

class SplashView extends StatelessWidget {
  static const String routeName ='/';

  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {
          Get.toNamed(LoginView.routeName);
        }, child: Text('data')),
      ),
    );
  }
}
