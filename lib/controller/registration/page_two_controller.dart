import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas/core/constant/theme.dart';
import 'package:nas/view/widget/button_border.dart';
import 'package:nas/view/widget/custom_snackbar.dart';

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
        showInfoSnackbar(message: 'الرجاء اختيار مهمة واحدة على الأقل');
      }
      return false;
    }
    return true;
  }

  void showSuccessDialog() {
    Get.dialog(
      Dialog(
        // Add margin to the entire Dialog
        insetPadding: EdgeInsets.symmetric(horizontal: 68),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            // height: 183,
            color: AppTheme.white,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  "طبيعة العمل تكون في المطبخ حيث تعمل مع الشيف",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),

                ButtonBorder(
                  height: 30,
                  borderRadius: 10,

                  onTap: () {
                    Get.back(); // Close the dialog
                  },
                  text: "إغلاق",
                  color: AppTheme.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
