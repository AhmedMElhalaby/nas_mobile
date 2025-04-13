// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nas/controller/home/main_home_controller.dart';
import 'package:nas/core/constant/theme.dart';
import 'package:nas/core/constant/url.dart';
import 'package:nas/view/screeen/main/notification_screen.dart';
import 'package:nas/view/widget/drawer.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainHomeController controller = Get.find<MainHomeController>();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppTheme.white,
          key: _scaffoldKey, // تعيين المفتاح هنا
          // backgroundColor: AppTheme.primaryColor,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Get.to(() => const NotificationScreen());
              },
              child: SizedBox(
                height: Get.height * 0.04,
                width: Get.width * 0.05,
                child: SvgPicture.asset(
                  "${AppUrl.rootIcons}/notification.svg",
                  height: Get.height * 0.04,
                  width: Get.width * 0.05,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            title: Image.asset(
              AppUrl.logo2,
              height: Get.height * 0.06,
              width: Get.width * 0.1,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.black),
                onPressed:
                    controller.toggleDrawer, // Toggle the drawer animation
              ),
            ],
          ),

          body: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              controller.selectedIndex.value = index;
            },
            children: controller.screens,
          ),
          bottomNavigationBar: Obx(
            () => Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 38),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Get.width * 0.12),
                color: AppTheme.white,
                border: Border.all(
                  color: AppTheme.primaryColor,
                  width: 3,
                ), // Dynamic border width
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                selectedItemColor: AppTheme.primaryColor,
                unselectedItemColor: Colors.grey.withOpacity(0.5),
                currentIndex: controller.selectedIndex.value,
                onTap: controller.changeIndex,
                selectedIconTheme: IconThemeData(
                  color: AppTheme.primaryColor,
                  size: Get.height * 0.03, // Dynamic size for selected icons
                ),

                selectedLabelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      AppTheme.primaryColor, // Ensure label color is consistent
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      AppTheme.transparent, // Ensure label color is consistent
                ),
                backgroundColor: Colors.transparent, // إزالة لون الخلفية
                elevation: 0, // إزالة الظل
                type: BottomNavigationBarType.fixed,
                items: _buildBottomNavigationBarItems(controller),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: controller.drawerAnimationController!,
          builder: (context, child) {
            // Only render drawer when it's not fully closed
            if (controller.drawerAnimationController!.value == 0.0) {
              return const SizedBox.shrink();
            }

            return SlideTransition(
              position: controller.slideAnimation!,
              child: drawer(controller),
            );
          },
        ),
      ],
    );
  }
}

List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
  MainHomeController controller,
) {
  final List<Map<String, String>> navItems = [
    {"icon": "new.svg", "label": "جديدة"},
    {"icon": "wait.svg", "label": "إنتظار"},
    {"icon": "accept.svg", "label": "موافقة"},
    {"icon": "violations.svg", "label": "مخالفات"},
  ];

  return List.generate(
    navItems.length,
    (index) => BottomNavigationBarItem(
      backgroundColor: Colors.transparent,
      icon: Material(
        color: Colors.transparent, // حتى ما يغير الخلفية

        child: GestureDetector(
          onTap: () => controller.changeIndex(index),
          // borderRadius: BorderRadius.circular(
          //   50,
          // ), // Optional for rounded effect
          child: Column(
            children: [
              SvgPicture.asset(
                "${AppUrl.rootIcons}/${navItems[index]['icon']}",
                color:
                    controller.selectedIndex.value == index
                        ? AppTheme
                            .primaryColor // Selected icon color
                        : AppTheme.transparent, // Unselected icon color
                height: 22,
                width: 22,
              ),
              SizedBox(height: 6),
            ],
          ),
        ),
      ),
      label: navItems[index]['label'],
    ),
  );
}
