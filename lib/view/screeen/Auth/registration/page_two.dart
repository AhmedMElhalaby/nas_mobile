import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nas/controller/registration/page_two_controller.dart';
import 'package:nas/core/constant/theme.dart';
import 'package:nas/view/widget/custom_checkbox.dart';
import 'package:nas/view/widget/custom_title.dart';

class PageTwo extends StatelessWidget {
  final PageTwoController controller;
  const PageTwo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTitle(
              title: "شو حابب تشتغل ؟",
              supText: true,
              supTitle: 'يمكنك اختيار اكثر من شي',
            ),
            SizedBox(height: 20),
            // Tasks List
            Obx(
              () =>
                  controller.tasks.isEmpty
                      ? Text(
                        "لا توجد مهام متاحة حاليًا",
                        style: AppTheme.textTheme16,
                      )
                      : Column(
                        children: List.generate(
                          controller.tasks.length,
                          (index) => CustomCheckbox(
                            icon: true,
                            title: controller.tasks[index],
                            textStyle: AppTheme.textTheme20,
                            isSelected: controller.selectedTasks[index],
                            onChanged: () => controller.toggleTask(index),
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
