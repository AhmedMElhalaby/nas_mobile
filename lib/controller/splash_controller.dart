import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas/view/screen/Auth/login.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAll(() => LoginScreen());
      });
    });
    super.onInit();
  }

  @override
  void onClose() {
    // Cleanup if needed
    super.onClose();
  }
}
