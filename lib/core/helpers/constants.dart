import 'package:flutter/material.dart';

bool isLoggedInUser = false;

class SharedPrefKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';

  static const String userName = 'full_name';
  static const String userPhoto = 'user_photo';
  static const String email = "email";
  static const String phone = "phone";
  static const String fcmToken = "fcm_token";

  static const String userId = 'user_id';

  static const deviceToken = 'device_token';
}


final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();