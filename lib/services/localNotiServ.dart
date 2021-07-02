import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        Navigator.of(context).pushNamed(payload);
      }
    });
  }

  static void display(RemoteMessage remoteMessage) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'FlutterCraft',
          'FlutterCraft',
          'This is our channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _flutterLocalNotificationsPlugin.show(
        id,
        remoteMessage.notification!.title,
        remoteMessage.notification!.body,
        notificationDetails,
        payload: remoteMessage.data['route'],
      );
    } on Exception catch (e) {}
  }
}
