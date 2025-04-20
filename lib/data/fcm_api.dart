import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FCMApi {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();
    final token = await firebaseMessaging.getToken();
    log("FCM Token: $token");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundFcm);
  }
}
// final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// Future<void> initNotification() async {
//   await _requestPermission();
//   await _configureDidReceiveNotification();
//   await _configureSelectNotificationSubject();
//   await _configureOnBackgroundMessageHandler();
// }
//
// Future<void> _requestPermission() async {
//   NotificationSettings settings = await _firebaseMessaging.requestPermission(
//     alert: true,
//     badge: true,
//     provisional: false,
//     sound: true,
//   );

Future<void> handleBackgroundFcm(RemoteMessage message) async {
  print("title : ${message.notification?.title}");
  print("body : ${message.notification?.body}");
}
