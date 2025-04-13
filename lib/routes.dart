import 'package:flutter/material.dart';

import 'package:nas/core/constant/routes.dart';
import 'package:nas/view/screeen/Auth/worker_registration_screen.dart';
import 'package:nas/view/screeen/Auth/login.dart';
import 'package:nas/view/screeen/main/drawer/change_password.dart';
import 'package:nas/view/screeen/main/drawer/change_wallet_number.dart';
import 'package:nas/view/screeen/main/drawer/edit_phone_number.dart';
import 'package:nas/view/screeen/main/drawer/job_selection_screen.dart';
import 'package:nas/view/screeen/main/drawer/modify_working_hours.dart';
import 'package:nas/view/screeen/main/location.dart';
import 'package:nas/view/screeen/main/main_home_screen.dart';
import 'package:nas/view/screeen/main/notification_screen.dart';
import 'package:nas/view/screeen/splach_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.splash: (context) => const SplachScreen(),
  AppRoute.login: (context) => const LoginScreen(),
  AppRoute.workerRegistration: (context) => const WorkerRegistrationScreen(),
  AppRoute.notification: (context) => const NotificationScreen(),
  AppRoute.mainHome: (context) => const MainHomeScreen(),

  AppRoute.location: (context) => const Location(),
  AppRoute.drawerJobSelection: (context) => JobSelectionScreen(),
  AppRoute.modifyWorkingHours: (context) => ModifyWorkingHours(),
  AppRoute.changeWalletNumber: (context) => ChangeWalletNumber(),
  AppRoute.changePassword: (context) => ChangePassword(),
  AppRoute.editPhoneNumber: (context) => EditPhoneNumber(),
};
