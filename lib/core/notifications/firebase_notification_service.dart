import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../helpers/shared_pref_helper.dart';
import '../helpers/constants.dart';
import 'notification_repo.dart';

class FirebaseNotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final NotificationRepo notificationRepo;

  final FlutterLocalNotificationsPlugin localNotifications =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel =
  AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  FirebaseNotificationService(this.notificationRepo,);

  Future<void> initialize() async {
    try {
      print("===== FIREBASE START =====");

      // ==========================================================
      // LOCAL NOTIFICATIONS INITIALIZATION
      // ==========================================================

      const androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      const darwinSettings = DarwinInitializationSettings();

      const initializationSettings = InitializationSettings(
        android: androidSettings,
        iOS: darwinSettings,
      );

      await localNotifications.initialize(
        initializationSettings,
      );

      // ==========================================================
      // ANDROID CHANNEL
      // ==========================================================

      await localNotifications
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);

      // ==========================================================
      // FCM PERMISSION
      // ==========================================================

      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      print(
        "Permission => ${settings.authorizationStatus}",
      );

      // ==========================================================
      // TOKEN
      // ==========================================================

      final token = await messaging.getToken();

      print("FCM TOKEN => $token");

      if (token != null) {
        await SharedPrefHelper.setSecuredString(
          SharedPrefKeys.fcmToken,
          token,
        );

        await notificationRepo.registerDeviceToken(
          fcmToken: token,
          deviceType: "android",
        );

        print("FCM TOKEN SENT SUCCESSFULLY");
      }

      // ==========================================================
      // FOREGROUND
      // ==========================================================

      FirebaseMessaging.onMessage.listen(
            (RemoteMessage message) async {
          print("🔥 FOREGROUND MESSAGE");

          print(
            "Title => ${message.notification?.title}",
          );

          print(
            "Body => ${message.notification?.body}",
          );

          print(
            "Data => ${message.data}",
          );

          await _showForegroundNotification(message);
        },
      );

      // ==========================================================
      // APP OPENED FROM BACKGROUND
      // ==========================================================

      FirebaseMessaging.onMessageOpenedApp.listen(
            (RemoteMessage message) {
          print("🔥 OPENED FROM NOTIFICATION");

          print(message.data);
        },
      );

      // ==========================================================
      // APP OPENED FROM TERMINATED
      // ==========================================================

      final initialMessage =
      await messaging.getInitialMessage();

      if (initialMessage != null) {
        print("🔥 TERMINATED OPEN");
        print(initialMessage.data);
      }

      print("===== FIREBASE END =====");
    } catch (e, s) {
      print("FCM ERROR => $e");
      print(s);
    }
  }

  Future<void> _showForegroundNotification(
      RemoteMessage message,
      ) async {
    final notification = message.notification;

    final title =
        notification?.title ?? message.data['title'];

    final body =
        notification?.body ?? message.data['body'];

    if (title == null && body == null) {
      return;
    }

    await localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title ?? 'Notification',
      body ?? '',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
          'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }
}