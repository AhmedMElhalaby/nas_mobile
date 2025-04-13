import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas/core/constant/theme.dart';
import 'package:nas/view/screeen/Auth/forgetPassword/change_password.dart';
import 'package:nas/view/screeen/Auth/forgetPassword/code_validate.dart';
import 'package:nas/view/screeen/Auth/login.dart';

class ForgetPasswordController extends GetxController {
  // Form key for validation
  // Separate GlobalKeys for different forms
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  // Text Controllers
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final otpCode = ''.obs;
  // Focus management for better user experience
  void handleFocusTransition(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    nextFocus.requestFocus();
  }

  bool validatePhoneNumber(String phoneNumber) {
    return phoneNumber.isNotEmpty;
    // &&
    // RegExp(r'^\+?[0-9]{10,15}$').hasMatch(phoneNumber);
  }

  sendCode() {
    print('Code sent to ${phoneController.text}');

    if (validatePhoneNumber(phoneController.text)) {
      // Simulate sending code
      print('Code sent to ${phoneController.text}');
      Get.snackbar(
        'Success',
        'Code sent successfully',
        backgroundColor: Colors.green,

        snackPosition: SnackPosition.BOTTOM,
      );
      Get.to(() => CodeValidate());
    } else {
      Get.snackbar(
        'Error',
        'Invalid phone number',
        backgroundColor: AppTheme.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void verifyOtp(String code) {
    otpCode.value = code;
    print("OTP verified: $code");
    // Navigate to ChangeToNewPassword screen
  }

  goToChangePassword() {
    if (otpCode.value.isNotEmpty) {
      Get.to(() => ChangeToNewPassword());
    } else {
      Get.snackbar(
        'Error',
        'Please enter a valid OTP code',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void updatePassword() {
    final password = passwordController.text.trim();
    Get.focusScope?.unfocus();

    final confirmPassword = confirmPasswordController.text.trim();
    print("password ${password}, confirmPassword ${confirmPassword}");
    if (password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        "خطأ",
        "يرجى إدخال كلمة المرور وتأكيدها",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        "خطأ",
        "كلمتا المرور غير متطابقتين",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Simulate a successful password update
    Get.snackbar(
      "نجاح",
      "تم تحديث كلمة المرور بنجاح",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Navigate to the login screen or another screen
    Get.off(() => LoginScreen()); // Replace '/login' with your login route
  }

  void changePassword() {
    if (passwordController.text == confirmPasswordController.text) {
      // Logic to change password
      print("Password changed successfully");
      Get.snackbar(
        'Success',
        'Password changed successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    print("Disposing ForgetPasswordController");
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.onClose();
  }
}
