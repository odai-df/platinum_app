import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theming/styles.dart';

class PlatinumImageAndText extends StatelessWidget {
  const PlatinumImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.68,
      child: Stack(
        children: [
          /// PROPERTY IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/plat2.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          /// SOFT GRADIENT
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                    0.35,
                    0.68,
                    1.0,
                  ],
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.25),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),


          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: Column(
              children: [
                Text(
                  'Discover Your\nPerfect Property'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyles.font32BlueBold.copyWith(
                    fontSize: 34,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
