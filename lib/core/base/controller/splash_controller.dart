import 'package:get/get.dart';
import 'package:task_management/core/utils/boxes.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  RxBool isLoggedIn = false.obs;

  logInCheck() async {
    isLoggedIn.value = HiveBoxes.getUserData().get('token') != null &&
        HiveBoxes.getUserData().get('token').toString().isNotEmpty;
  }

  @override
  void onInit() {
    logInCheck();
    super.onInit();
  }
}
