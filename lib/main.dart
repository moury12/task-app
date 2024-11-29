import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_management/core/base/bloc/splash/splash_bloc.dart';
import 'package:task_management/core/base/bloc/user/user_bloc.dart';

import 'package:task_management/core/init/theme.dart';
import 'package:task_management/view/auth/login_view.dart';
import 'package:task_management/view/auth/registration_view.dart';
import 'package:task_management/view/auth/splash_view.dart';
import 'package:task_management/view/task/task_view.dart';
import 'package:task_management/view/user-profile/edit_profile_view.dart';

import 'view/home/home_view.dart';
import 'view/user-profile/user_profile_view.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("userInfo");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashBloc(),
          ),
          BlocProvider(
            create: (context) => UserBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Task Management',
          theme: themeData,
          home: const SplashView(),
          routes: {
            LoginView.routeName: (context) => const LoginView(),
            HomeView.routeName: (context) => const HomeView(),
            UserProfileView.routeName: (context) => const UserProfileView(),
            TaskView.routeName: (context) => const TaskView(),
            RegistrationView.routeName: (context) => const RegistrationView(),
            EditProfileView.routeName: (context) => const EditProfileView(),
          },
        ),
      ),
    );
  }
}
