import 'package:get/get.dart';
import 'package:task_management/core/init/bindings.dart';
import 'package:task_management/view/auth/login_view.dart';
import 'package:task_management/view/auth/splash_view.dart';

class AppRoutes{
  static routes()=>[
GetPage(name: '/', page: () => const SplashView(),),
GetPage(name: LoginView.routeName, page: () => const LoginView(),binding: AuthBinding()
)
  ];
}