import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:platinum_app/core/helpers/extensions.dart';
import 'package:platinum_app/core/theming/colors.dart';
import 'package:platinum_app/core/theming/styles.dart';

import '../../../core/routing/routes.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.pushNamed(Routes.loginScreen);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorsManager.mainBlue),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 52),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      child: Text(
        'Get Started'.tr(),
        style: TextStyles.font16WhiteMedium,
      ),
    );
  }
}
