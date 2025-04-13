import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageTwoController extends GetxController {
  RxList<bool> selectedTasks = <bool>[].obs;

  final List<String> tasks = [
    'مقدم طعام وشراب',
    'مساعد طاهي',
    'منظف غرف',
    'منظف مرافق',
    'نظافة وجلي المطبخ',
    'تحميل وتنزيل',
  ];
  taskSelectionController() {
    // Initialize with false for each task
    selectedTasks.value = List.generate(tasks.length, (index) => false);
  }

  @override
  void onInit() {
    super.onInit();
    taskSelectionController(); // تهيئة القيم عند البداية
  }

  bool rememberMe = false;

  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    update();
  }

  void toggleTask(int index) {
    if (index >= 0 && index < selectedTasks.length) {
      selectedTasks[index] = !selectedTasks[index];
      selectedTasks.refresh(); // Notify listeners of the change
    }
  }

  void saveSelection() {
    if (validate()) {
      Get.snackbar(
        'تم الحفظ',
        'تم حفظ اختياراتك بنجاح',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  bool get isAnyTaskSelected => selectedTasks.any((task) => task == true);
  // Retrieve form data
  Map<String, dynamic> getFormData() {
    List<String> selectedTaskNames =
        tasks
            .asMap()
            .entries
            .where((entry) => selectedTasks[entry.key])
            .map((entry) => entry.value)
            .toList();

    return {'selectedTasks': selectedTaskNames, 'rememberMe': rememberMe};
  }

  bool validate({bool showSnackbar = true}) {
    if (isAnyTaskSelected == false) {
      if (showSnackbar) {
        Get.snackbar(
          'تنبيه',
          'الرجاء اختيار مهمة واحدة على الأقل',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.amber,
          colorText: Colors.black,
        );
      }
      return false;
    }
    return true;
  }
}
