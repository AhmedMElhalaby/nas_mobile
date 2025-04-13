import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageSevenController extends GetxController {
  final genderOptions = ['ذكر', 'أنثى'];
  final maritalStatusOptions = ['أعزب', 'متزوج'];
  final List<String> countryCodeOptions = [
    '+970',
    '+972',
    '+962',
    '+966',
    '+967',
  ];

  final RxString selectedCountryCode = '+970'.obs;
  final RxString selectedGender = ''.obs;
  final RxString selectedMaritalStatus = ''.obs;
  final TextEditingController phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();
  RxBool isPhoneSelected = false.obs;
  @override
  void onClose() {
    // Dispose of controllers and focus nodes to prevent memory leaks
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.onClose();
  }

  void setCountryCode(String? code) {
    if (code != null) {
      selectedCountryCode.value = code;
    }
  }

  void setGender(String? value) {
    selectedGender.value = value ?? '';
  }

  void setMaritalStatus(String? value) {
    selectedMaritalStatus.value = value ?? '';
  }

  bool validateForm() {
    return selectedGender.isNotEmpty &&
        selectedMaritalStatus.isNotEmpty &&
        phoneController.text.isNotEmpty;
  }

  void submitForm() {
    if (validateForm()) {
      // Handle form submission
      Get.snackbar(
        'نجاح',
        'تم تسجيل البيانات بنجاح',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'خطأ',
        'يرجى ملء جميع الحقول',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Map<String, dynamic> getFormData() {
    return {
      'gender': selectedGender.value,
      'maritalStatus': selectedMaritalStatus.value,
      'countryCode': selectedCountryCode.value,
      'phoneNumber': phoneController.text,
      'fullPhone': '${selectedCountryCode.value}${phoneController.text}',
    };
  }

  bool validate({bool showSnackbar = true}) {
    if (!validateForm()) {
      if (showSnackbar) {
        Get.snackbar(
          'تنبيه',
          'الرجاء إكمال جميع الحقول المطلوبة',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.amber,
          colorText: Colors.black,
        );
      }
      return false;
    }
    return true;
  }

  // Focus management for better user experience
  void handleFocusTransition(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    nextFocus.requestFocus();
  }
}
