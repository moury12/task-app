import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/core/utils/boxes.dart';
import 'package:task_management/view/auth/login_view.dart';

class HomeView extends StatelessWidget {
  static const String routeName = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                HiveBoxes.getUserData().delete('token');
                Get.offAndToNamed(LoginView.routeName);
              },
              child: Text('logout'))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },),
    );
  }
}
