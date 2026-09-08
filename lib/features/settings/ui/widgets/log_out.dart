import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/notifications/notification_repo.dart';
import '../../../../core/routing/routes.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_extension.dart';

class SettingsLogoutTile extends StatelessWidget {
  const SettingsLogoutTile({super.key});

  void _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Text(
            'Confirm Logout'.tr(),
            style: TextStyle(
              color: context.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to log out?'.tr(),
            style: TextStyle(
              color: context.subTextColor,
              height: 1.5,
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          actions: [
            /// CANCEL
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel'.tr(),
                style: TextStyle(
                  color: context.subTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            /// LOGOUT
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {

                final navigator = Navigator.of(context);

                navigator.pop();

                final fcmToken =
                await SharedPrefHelper.getSecuredString(
                  SharedPrefKeys.fcmToken,
                );

                if (fcmToken != null && fcmToken.isNotEmpty) {
                  await getIt<NotificationRepo>()
                      .deleteDeviceToken(fcmToken);
                }

                await SharedPrefHelper.clearAllData();

                await SharedPrefHelper.clearAllSecuredData();

                isLoggedInUser = false;

                navigator.pushNamedAndRemoveUntil(
                  Routes.loginScreen,
                      (route) => false,
                );
              },
              child:  Text(
                'Log Out'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              context.isDark ? 0.25 : 0.05,
            ),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 6,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
        ),
        title: Text(
          "Logout".tr(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: context.textColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: context.subTextColor,
        ),
        onTap: () => _logout(context),
      ),
    );
  }
}
