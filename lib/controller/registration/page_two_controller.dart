import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas/controller/registration/custom_bottom_sheet.dart';

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

  void showSuccessDialog(int index) {
    Get.bottomSheet(
      CustomBottomSheet(
        title: tasks[index],
        documentType: '''
سياسة : السلامة هي محور إهتمامنا الأولقاعدة العمل: يجب على الأفراد إرتداء خوذة عند تواجدهم في موقع البناء.يجب على المفتشين القيام بدورات تفتيشية أسبوعية على مواقع البناء والتأكد من استيفاء اشتراطات السلامة.إذا تعطلت آلة تكسير الخرسانة في الموقع فيجب تبديلها خلال 4 ساعات من العطل.سياسة: نحرص على أن نقوم بأعمال الصيانة بطريقة تزيد من عمر الأجهزة وفعاليتهاقاعدة العمل: إذا مر عام على تسليم الأجهزة لفريق العمل فيجب على فني الصيانة مراجعة الأجهزة المسلمة للفريق والتأكد من أن لا تقل سرعتها عن...
كما نرى قواعد العمل مكتوبة على مستوى تشغيلي محدد يمكن قياسه واختباره.
لماذا نضيع الوقت في كتابة سياسات تبدو عامة وتحتاج دائماً إلى تفسير؟ لماذا لا نكتب قواعد العمل مباشرة؟
السياسات المكتوبة بشكل جيد تحرر وقت القيادات من الإنشغال بالمواقف التشغيلية التي يمكن أن يعالجها الموظفات والموظفين بشيء من الحرية والسرعة التي يتطلبها الموقف التشغيلي دون إشراك القيادات، السياسات المكتوبة بشكل جيد توضح حدود الموظفات والموظفين في اتخاذ القرار وتمنحهم قدر جيد من الحرية لتغيير قواعد عملهم بما يتناسب مع الإحتياجات المتغيرة للعمليات التشغيلية.''',
        termIndex: index, // ⬅️ نمرر الفهرس هنا
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: true,
    );
  }
}
