import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService instance = NotificationService._();
  NotificationService._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  init() {
    AndroidInitializationSettings androidInitializationSettings =
    const AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings darwinInitializationSettings =
    const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();

    tz.initializeTimeZones();
  }

  void showNotification(String text) {
    flutterLocalNotificationsPlugin.show(
      Random().nextInt(100),
      'Flutter N8',
      text,
      const NotificationDetails(
        android: AndroidNotificationDetails('Nimadur', 'Nimadurde',
            importance: Importance.high,
            priority: Priority.max,
            fullScreenIntent: true,
            audioAttributesUsage: AudioAttributesUsage.alarm,
            actions: [
              AndroidNotificationAction('1', 'Salom', inputs: [
                AndroidNotificationActionInput(),
              ]),
            ]),
      ),
    );
  }

  void showNotificatoinOnPeriod() async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      2,
      'Flutter N8',
      'Darsga kelmaganlar o\'zidan ko\'rsin',
      RepeatInterval.daily,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'Nimadur',
          'Nimadurde',
          importance: Importance.low,
          priority: Priority.low,
        ),
      ),
    );
  }

  void showNotifWithDateTime() {
    flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      'Flutter N8',
      'Darsga kelmaganlar o\'zidan ko\'rsin',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'Nimadur2',
          'Nimadurde2',
          importance: Importance.low,
          priority: Priority.low,
        ),
      ),
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}