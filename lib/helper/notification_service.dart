import 'dart:async';
import 'dart:convert';
import 'package:app_tnh2/screens/home/noti/noti.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FireBaseApi {
  static StreamController<ReceivedNotification> notificationStreamController =
      StreamController<ReceivedNotification>.broadcast();

  static Stream<ReceivedNotification> get notificationStream =>
      notificationStreamController.stream;

  static Future<void> initNotification(BuildContext context) async {
    // Initialize Android settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    // Initialize iOS settings
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        notificationStreamController.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
    );

    // Set the foreground notification presentation options for iOS
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Request permissions for iOS
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Initialize notifications
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) {
      String? payload = notificationResponse.payload;
      if (payload != null) {
        Map<String, dynamic> data = json.decode(payload);
        final eventId = data['EventId'];
        if (eventId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotiScreen()),
          );
        } else {
          print('EventId is null');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotiScreen()),
          );
        }
      }
    });
  }

  static Future getDeviceToken() async {
    try {
      String? tokenNoti = await FirebaseMessaging.instance.getToken();
      return tokenNoti;
    } catch (e) {
      print('FirebaseMessaging.instance.getToken $e');
      return null;
    }
  }

  static Future<void> pushNotification(BuildContext context) async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotiScreen()),
        );
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        // แปลง RemoteNotification เป็น Map ก่อน
        Map<String, dynamic> notificationJson = {
          'title': notification.title,
          'body': notification.body,
          'android': notification.android?.toMap(),
          'apple': notification.apple?.toMap(),
        };

        String jsonString = json.encode(notificationJson);
        print(jsonString);
      } else {
        print("No notification data available");
      }
      if (message.notification != null) {
        FireBaseApi.showNotification(message);
      }
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  }

  static void showNotification(RemoteMessage message) async {
    // Create Android notification channel
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'BAAC_Channel_ID',
      'BAAC Importance Notifications',
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Android notification details
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      icon: '@mipmap/launcher_icon',
      styleInformation:
          BigTextStyleInformation(message.notification?.body ?? ''),
    );

    // iOS notification details
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // Notification details
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // Show notification
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: json.encode(message.data),
    );
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
