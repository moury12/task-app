import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/core/base/controller/splash_controller.dart';
import 'package:task_management/view/auth/login_view.dart';
import 'package:task_management/view/home/home_view.dart';

class SplashView extends StatefulWidget {
  static const String routeName ='/';

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Get.offAndToNamed(
        SplashController.to.isLoggedIn.value
            ? HomeView.routeName
            : LoginView.routeName,
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child:CircularProgressIndicator()
      ),
    );
  }
}
