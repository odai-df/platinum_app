import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_extension.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'By logging, you agree to our'.tr(),
            style: TextStyle(
              color: context.subTextColor,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          TextSpan(
            text: ' Terms & Conditions'.tr(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          TextSpan(
            text: ' and'.tr(),
            style: TextStyle(
              color: context.subTextColor,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          TextSpan(
            text: ' Privacy Policy'.tr(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
