import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/core/routing/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/helpers/constants.dart';
import 'core/routing/routes.dart';
import 'core/theming/app_theme.dart';
import 'core/theming/theme_cubit.dart';
import 'core/theming/theme_state.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class DocApp extends StatelessWidget {
  final AppRouter appRouter;

  const DocApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: state.themeMode,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              title: 'Platinum App'.tr(),
              debugShowCheckedModeBanner: false,
              initialRoute:
                  isLoggedInUser ? Routes.homeScreen : Routes.onBoardingScreen,
              onGenerateRoute: appRouter.generateRoute,
            );
          },
        );
      },
    );
  }
}
