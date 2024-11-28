import 'package:flutter/material.dart';
import 'package:task_management/core/utils/boxes.dart';
import 'package:task_management/view/auth/login_view.dart';
import 'package:task_management/view/user-profile/user_profile_view.dart';

class HomeView extends StatelessWidget {
  static const String routeName = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: () {
          Navigator.pushNamed(context, UserProfileView.routeName);
        }, icon: Icon(Icons.account_box)),
        actions: [
          
          TextButton(
              onPressed: () {
                HiveBoxes.getUserData().delete('token');
                Navigator.pushReplacementNamed(context, LoginView.routeName);
              },
              child: Text('logout'))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },),
    );
  }
}
