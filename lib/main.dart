import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/di/dependency_injection.dart';
import 'package:platinum_app/core/helpers/extensions.dart';
import 'package:platinum_app/platinum_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/helpers/constants.dart';
import 'core/helpers/shared_pref_helper.dart';

import 'core/routing/app_router.dart';
import 'core/theming/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  setupGetIt();

  await checkIfLoggedInUser();

  if (isLoggedInUser) {
    FirebaseMessaging.onBackgroundMessage(
      firebaseBackgroundHandler,
    );
  }

  await EasyLocalization.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: BlocProvider(
        create: (context) => getIt<ThemeCubit>(),
        child: DocApp(
          appRouter: AppRouter(),
        ),
      ),
    ),
  );
}

checkIfLoggedInUser() async {
  String? userToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.accessToken);
  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}

Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("BACKGROUND MESSAGE");

  print(message.notification?.title);
}
