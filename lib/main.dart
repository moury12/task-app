import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_management/core/base/bloc/splash/splash_bloc.dart';
import 'package:task_management/core/base/bloc/user/user_bloc.dart';
import 'package:task_management/core/constants/color_constants.dart';
import 'package:task_management/core/constants/text_style_constant.dart';
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
          theme: ThemeData(
            primaryColor: kBlackColor,
            scaffoldBackgroundColor: Colors.white,

            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,surfaceTintColor: Colors.transparent,
              foregroundColor: kBlackColor,
              titleTextStyle: textStyle16MediumBlack,

            ),
            dialogTheme: DialogTheme(backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            ),
            cardTheme: CardTheme(
              surfaceTintColor: Colors.white,
              color: Colors.white
            ),
            listTileTheme: ListTileThemeData(
              titleTextStyle: textStyle16SemiBoldBlack,
                  subtitleTextStyle: textStyle12NormalBlack
            ),
            drawerTheme: DrawerThemeData(backgroundColor: Colors.white,surfaceTintColor: Colors.white,
            width: MediaQuery.sizeOf(context).width/1.5),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.grey.shade100,
              foregroundColor: kBlackColor
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(kBlackColor), // Button background color
                foregroundColor: WidgetStateProperty.all(kWhiteColor), // Text color

                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) return Colors.grey[400]; // Ripple effect
                    return null;
                  },
                ),

    shape: WidgetStateProperty.all(
    RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0), // Rounded corners
    ),),
                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)), // Padding
                textStyle: WidgetStateProperty.all(const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                )), //
              )
            ),
            textButtonTheme:TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(kBlackColor), // Text color

                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) return Colors.grey[400]; // Ripple effect
                    return null;
                  },
                ),
                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0)), // Padding
                textStyle: WidgetStateProperty.all(const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                )), // Text style

              ),
            ),
          ),

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
