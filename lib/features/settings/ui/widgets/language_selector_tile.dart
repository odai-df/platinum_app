import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/networking/dio_factory.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/theme_extension.dart';

class LanguageSelectorTile extends StatelessWidget {
  const LanguageSelectorTile({super.key});

  @override
  Widget build(BuildContext context) {

    final currentLang =
        context.locale.languageCode;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color: context.cardColor,

        borderRadius:
        BorderRadius.circular(18),

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
        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 6,
        ),

        leading: Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color:
            AppColors.primary.withOpacity(0.12),

            borderRadius:
            BorderRadius.circular(14),
          ),

          child: const Icon(
            Icons.language,
            color: AppColors.primary,
          ),
        ),

        title: Text(
          'choose_language'.tr(),

          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: context.textColor,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),

          child: Text(
            currentLang == 'en'
                ? 'English'.tr()
                : 'العربية'.tr(),

            style: TextStyle(
              color: context.subTextColor,
            ),
          ),
        ),

        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
          color: context.subTextColor,
        ),

        onTap: () {
          showLanguageBottomSheet(
            context,
            currentLang,
          );
        },
      ),
    );
  }

  void showLanguageBottomSheet(
      BuildContext context,
      String currentLang,
      ) {

    showModalBottomSheet(
      context: context,

      backgroundColor:
      context.cardColor,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),

      builder: (context) {

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              /// HANDLE
              Container(
                width: 50,
                height: 5,

                decoration: BoxDecoration(
                  color: context.subTextColor
                      .withOpacity(0.3),

                  borderRadius:
                  BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 22),

              Text(
                "choose_language".tr(),

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.textColor,
                ),
              ),

              const SizedBox(height: 20),

              /// ENGLISH
              _languageTile(
                context: context,
                flag: "🇬🇧",
                title: "English",
                selected:
                currentLang == 'en',

                onTap: () async {

                  await SharedPrefHelper.setData(
                    "app_lang",
                    "en",
                  );

                  await context.setLocale(
                    const Locale('en'),
                  );

                  DioFactory.addDioHeaders();

                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 12),

              /// ARABIC
              _languageTile(
                context: context,
                flag: "🇸🇦",
                title: "العربية",
                selected:
                currentLang == 'ar',

                onTap: () async {

                  await SharedPrefHelper.setData(
                    "app_lang",
                    "ar",
                  );

                  await context.setLocale(
                    const Locale('ar'),
                  );

                  DioFactory.addDioHeaders();

                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _languageTile({
    required BuildContext context,
    required String flag,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {

    return InkWell(
      borderRadius: BorderRadius.circular(18),

      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              .withOpacity(0.12)
              : context.bgColor,

          borderRadius:
          BorderRadius.circular(18),

          border: Border.all(
            color: selected
                ? AppColors.primary
                : Colors.transparent,
          ),
        ),

        child: Row(
          children: [

            Text(
              flag,
              style: const TextStyle(
                fontSize: 28,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textColor,
                ),
              ),
            ),

            if (selected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}