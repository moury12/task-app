import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_management/core/base/service/auth_service.dart';
import 'package:task_management/core/utils/boxes.dart';
import 'package:task_management/core/utils/helper_function.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  Rx<TextEditingController> emailLoginController = TextEditingController().obs;
  Rx<TextEditingController> passwordLoginController =
      TextEditingController().obs;
  RxString token = ''.obs;
  loginCall({required String email, required String password}) async {
    token.value =
        await AuthService.loginRequest(email: email, password: password);
    if(token.value.isNotEmpty){
HiveBoxes.getUserData().put('token', token);
log("-----token---------- ${HiveBoxes.getUserData().values.toString()}");
    }else{
// showCustomSnackbar(title: 'Failed', message: "Something went wrong", type: SnackBarType.failed);
    }
  }
}
