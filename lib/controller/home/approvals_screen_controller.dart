import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas/core/constant/theme.dart';
import 'package:nas/data/model/job_request.dart';
import 'package:nas/view/screeen/main/location.dart';
import 'package:nas/view/widget/button_border.dart';

class ApprovalsScreenController extends GetxController {
  var approvalsList = <JobRequest>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApprovals();
  }

  void fetchApprovals() {
    isLoading.value = true;
    // Simulate API call delay
    approvalsList.value = [
      JobRequest(
        title: 'مقدم طعام',
        date: 'الأحد - 15/2',
        timeRange: '2:00م إلى 8:00م',
      ),
      JobRequest(
        title: 'مقدم طعام',
        date: 'الأحد - 15/2',
        timeRange: '2:00م إلى 8:00م',
      ),
      JobRequest(
        title: 'مقدم طعام',
        date: 'الأحد - 15/2',
        timeRange: '2:00م إلى 8:00م',
      ),
      JobRequest(
        title: 'مقدم طعام',
        date: 'الأحد - 15/2',
        timeRange: '2:00م إلى 8:00م',
      ),
    ];
    isLoading.value = false;
  }

  void removeRequest(int index) {
    showDeleteDialog(index);
  }

  void approveRequest(int index) {
    // Implement approval logic
    Get.to(() => const Location()); // إذا كنتِ تستخدمين GetX

    Get.snackbar(
      'تمت الموافقة',
      'تمت الموافقة على الطلب بنجاح',
      snackPosition: SnackPosition.BOTTOM,
    );
    // removeRequest(index);
  }

  void showDeleteDialog(index) {
    Get.dialog(
      Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.black.withOpacity(0.5), // لون داكن شفاف
            ),
          ),
          Dialog(
            shadowColor: AppTheme.backgroundTransparent,
            // Add margin to the entire Dialog
            insetPadding: EdgeInsets.symmetric(horizontal: 54),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "يمكن أن تؤدي عملية الإلغاء إلى خفض درجاتك أو حظرك عن العمل",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: Get.height * 0.026),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonBorder(
                        height: Get.height * 0.04,
                        borderRadius: 10,
                        onTap: () {
                          approvalsList.removeAt(index);
                          Get.back();
                          Get.snackbar(
                            'تم الإلغاء',
                            'تم إلغاء الطلب بنجاح',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        text: 'تأكيد',
                        color: AppTheme.red,
                      ),
                      SizedBox(width: 30),
                      ButtonBorder(
                        height: Get.height * 0.04,
                        borderRadius: 10,
                        onTap: () => Get.back(),
                        text: "إغلاق",
                        color: AppTheme.primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
