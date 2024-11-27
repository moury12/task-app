import 'package:get/get.dart';
import 'package:task_management/core/base/controller/auth_controller.dart';
import 'package:task_management/core/base/controller/splash_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(
      AuthController(),
    );


  }
}
class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }

}