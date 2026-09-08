import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:platinum_app/core/helpers/extensions.dart';
import 'package:platinum_app/core/routing/routes.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_extension.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an account?'.tr(),
            style: TextStyle(
              color: context.subTextColor,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          TextSpan(
            text: ' Sign Up'.tr(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacementNamed(
                  Routes.signUpScreen,
                );
              },
          ),
        ],
      ),
    );
  }
}
