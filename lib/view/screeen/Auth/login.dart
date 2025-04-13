import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nas/controller/login_controller.dart';
import 'package:nas/core/constant/theme.dart';
import 'package:nas/core/constant/url.dart';
import 'package:nas/view/widget/button_border.dart';
import 'package:nas/view/widget/custom_checkbox.dart';
import 'package:nas/view/widget/primary_button.dart';
import 'package:nas/view/widget/text_form_filed_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final LoginController controller = Get.find<LoginController>();

    final width = Get.width;
    final height = Get.height;
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.1),

                Center(
                  child: Image.asset(
                    AppUrl.logo,
                    width: width * 0.3,
                    height: width * 0.3,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: height * 0.08),

                Form(
                  // key: controller.formstate,
                  child: Column(
                    children: [
                      GetBuilder<LoginController>(
                        builder:
                            (_) => TextFormFiledWidget(
                              text: 'رقم الهاتف',
                              keyboardType: TextInputType.phone,
                              onEditingComplete:
                                  () => controller.handleFocusTransition(
                                    controller.phoneFocusNode,
                                    controller.passwordFocusNode,
                                  ),
                              focusNode: controller.phoneFocusNode,
                              textEditingController: controller.phoneController,
                            ),
                      ),

                      SizedBox(height: height * 0.06),

                      GetBuilder<LoginController>(
                        builder:
                            (_) => TextFormFiledWidget(
                              text: "كلمة المرور",
                              isPassword: true,
                              onEditingComplete:
                                  () => controller.passwordFocusNode.unfocus(),
                              focusNode: controller.passwordFocusNode,
                              textEditingController:
                                  controller.passwordController,
                            ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.03),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: GetBuilder<LoginController>(
                          builder:
                              (_) => CustomCheckbox(
                                icon: false,
                                padding: EdgeInsets.only(top: height * 0.01),
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                title: "تذكرني",
                                isSelected: controller.rememberMe,
                                onChanged:
                                    () => controller.toggleRememberMe(
                                      !controller.rememberMe,
                                    ), // تمرير القيمة الجديدة
                              ),
                        ),
                      ),
                      TextButton(
                        onPressed: controller.forgotPassword,
                        child: Text(
                          'نسيت كلمة المرور؟',
                          style: AppTheme.textTheme16.copyWith(
                            color: AppTheme.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),

                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        onTap: controller.login,
                        text: "دخول",
                      ),
                    ),

                    SizedBox(width: width * 0.08),

                    Expanded(
                      child: ButtonBorder(
                        onTap: controller.joinWork,

                        text: "إنضم للعمل",
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: GestureDetector(
                    onTap: controller.needHelp,
                    child: Text(
                      'تحتاج مساعدة؟',
                      style: AppTheme.textTheme16.copyWith(
                        color: AppTheme.transparent,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
