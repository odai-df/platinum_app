import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:platinum_app/core/theming/theme_extension.dart';
import 'package:platinum_app/features/settings/ui/widgets/log_out.dart';
import 'package:platinum_app/features/settings/ui/widgets/theme_switcher_tile.dart';
import 'widgets/language_selector_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        backgroundColor: context.bgColor,
        title: Text('Settings'.tr()),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: const [
          LanguageSelectorTile(),
          ThemeSwitcherTile(),
          SettingsLogoutTile(),

        ],
      ),
    );
  }
}
