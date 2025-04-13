import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas/view/screeen/main/approvals_screen.dart';
import 'package:nas/view/screeen/main/new_screen.dart';
import 'package:nas/view/screeen/main/violations_screen.dart';
import 'package:nas/view/screeen/main/waiting_screen.dart';

class MainHomeController extends GetxController
    with GetTickerProviderStateMixin {
  var selectedIndex = 0.obs;
  final PageController pageController = PageController();

  final screens = [
    NewScreen(),
    WaitingScreen(),
    ApprovalsScreen(),
    ViolationsScreen(),
  ];
  AnimationController? drawerAnimationController;
  Animation<Offset>? slideAnimation;
  Animation<double>? fadeAnimation;

  var isDrawerOpen = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize the AnimationController for the drawer
    drawerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Define the sliding animation
    slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start off-screen to the left
      end: Offset.zero, // End at the original position
    ).animate(
      CurvedAnimation(
        parent: drawerAnimationController!,
        curve: Curves.easeInOut,
      ),
    );
    // Add a listener to handle the drawer's state change after the animation completes
    drawerAnimationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Drawer has finished opening
      } else if (status == AnimationStatus.dismissed) {
        // Drawer has finished closing
        isDrawerOpen.value = false;
      }
    });
  }

  // Method to toggle the drawer
  void toggleDrawer() {
    if (isDrawerOpen.value) {
      drawerAnimationController?.reverse();
    } else {
      drawerAnimationController?.forward();
    }
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  // Getter to return the currently selected screen
  Widget get currentScreen {
    // Ensure the selectedIndex is within bounds
    if (selectedIndex.value < 0 || selectedIndex.value >= screens.length) {
      return screens[0]; // Default to the first screen if out of bounds
    }
    return screens[selectedIndex.value];
  }

  // Method to change the selected index and animate the page transition
  void changeIndex(int index) {
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    // Dispose of the PageController and AnimationController
    pageController.dispose();
    drawerAnimationController
        ?.dispose(); // Explicitly dispose the drawer animation controller
    super.onClose();
  }
}
