import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nas/controller/registration/page_two_controller.dart';
import 'package:nas/core/constant/theme.dart';
import 'package:nas/view/widget/button_border.dart';
import 'package:nas/view/widget/custom_checkbox.dart';
import 'package:nas/view/widget/custom_title.dart';
import 'package:nas/view/widget/primary_button.dart';

class JobSelectionScreen extends StatelessWidget {
  const JobSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageTwoController controller = Get.find<PageTwoController>();

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 49.w),
          child: Column(
            children: [
              SizedBox(height: Get.height / 6),

              CustomTitle(
                title: "شو حابب تشتغل ؟",
                supText: true,
                supTitle: 'يمكنك اختيار اكثر من شي',
              ),

              SizedBox(height: 20.h),
              Obx(
                () =>
                    controller.tasks.isEmpty
                        ? Text(
                          "لا توجد مهام متاحة حاليًا",
                          style: AppTheme.textTheme16,
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            controller.tasks.length,
                            (index) => CustomCheckbox(
                              icon: false,
                              richText: Expanded(
                                child: Text(
                                  controller.tasks[index],
                                  style: AppTheme.textTheme20,
                                ),
                              ),
                              title: controller.tasks[index],
                              textStyle: AppTheme.textTheme20,
                              isSelected: controller.selectedTasks[index],
                              onChanged: () => controller.toggleTask(index),
                            ),
                          ),
                        ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: Get.height / 10.h,
          left: 50.w,
          right: 50.w,
        ),
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                onTap: () {
                  Get.back();
                },
                text: "حفظ",
              ),
            ),

            SizedBox(width: 40.w),

            Expanded(
              child: ButtonBorder(
                onTap: () {
                  Get.back();
                },
                text: "عودة",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
