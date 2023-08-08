import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../data/local/db/local_database.dart';
import '../data/models/news_model.dart';
import 'local_notification_services.dart';

String title = "";
String description = "";
String image = "";

Future<void> initFirebase() async {



  await Firebase.initializeApp();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.subscribeToTopic("news");

  // FOREGROUND MESSAGE HANDLING.
  FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
    title = message.data["title"];
    description = message.data["description"];
    image = message.data["image"];
    await LocalDatabase.insertNews(NewsModel(title: title, description: description, image: image));
    debugPrint("11111");
    LocalNotificationService.instance.showFlutterNotification(message);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  handleMessage(RemoteMessage message)async {
    title = message.data["title"];
    description = message.data["description"];
    image = message.data["image"];
    debugPrint("22222");
    LocalNotificationService.instance.showFlutterNotification(message);
  }

  RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (remoteMessage != null) {
    handleMessage(remoteMessage);
  }

  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  title = message.data["title"];
  description = message.data["description"];
  image = message.data["image"];
  await LocalDatabase.insertNews(NewsModel(title: title, description: description, image: image));
  debugPrint("33333");
}