import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_management/core/constants/app_routes.dart';
import 'package:task_management/core/init/bindings.dart';
import 'package:task_management/view/auth/splash_view.dart';

void main() async{
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
      child: GetMaterialApp(
        title: 'Task Management',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        getPages: AppRoutes.routes(),
        initialRoute: SplashView.routeName,
        initialBinding: InitialBinding(),
      ),
    );
  }
}


