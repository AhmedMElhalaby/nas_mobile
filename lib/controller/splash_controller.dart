import 'package:get/get.dart';
import 'package:nas/view/screeen/Auth/login.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAll(
        () => LoginScreen(),
      ); // This will remove the splash screen and navigate to HomeScreen
    });
    super.onInit();
  }

  @override
  void onClose() {
    // Cleanup if needed
    super.onClose();
  }
}
