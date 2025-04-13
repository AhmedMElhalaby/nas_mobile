import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas/controller/splash_controller.dart';
import 'package:nas/core/constant/theme.dart';
import 'package:nas/core/constant/url.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    // Get screen dimensions to calculate responsive values
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    // Calculate logo size based on screen dimensions
    final logoSize = screenHeight * 0.25;

    // Calculate font sizes based on screen dimensions
    final fontSize = (screenHeight * 0.04).clamp(20.0, 36.0);

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              duration: const Duration(seconds: 3),
              tween: Tween<double>(begin: 0.2, end: 1),
              curve: Curves.easeInOut,
              builder: (context, scale, child) {
                return AnimatedOpacity(
                  opacity: scale, // Also animate opacity based on scale
                  duration: const Duration(seconds: 3),
                  child: Transform.scale(scale: scale, child: child),
                );
              },
              child: Image.asset(
                AppUrl.logo,
                width: logoSize,
                height: logoSize,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            TweenAnimationBuilder(
              duration: const Duration(seconds: 3),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, opacity, child) {
                return Opacity(opacity: opacity, child: child);
              },
              child: Text(
                "يوم  جديد!!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontFamily: 'El Messiri',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            TweenAnimationBuilder(
              duration: const Duration(seconds: 3),
              tween: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
              curve: Curves.easeInOut,
              builder: (context, offset, child) {
                return SlideTransition(
                  position: AlwaysStoppedAnimation(offset),
                  child: child,
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 60.0),
                child: Text(
                  "شغل جديد!!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontFamily: 'El Messiri',
                    fontWeight: FontWeight.w500,
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
