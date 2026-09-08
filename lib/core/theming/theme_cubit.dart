import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_state.dart';
import '../helpers/shared_pref_helper.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.light)) {
    loadTheme();
  }

  Future<void> toggleTheme() async {
    final isDark = state.themeMode == ThemeMode.dark;

    final newTheme = isDark ? ThemeMode.light : ThemeMode.dark;

    emit(
      ThemeState(newTheme),
    );

    await SharedPrefHelper.setData(
      'theme_mode',
      newTheme == ThemeMode.dark ? 'dark' : 'light',
    );
  }

  Future<void> loadTheme() async {
    final saved = await SharedPrefHelper.getString('theme_mode');

    if (saved == 'dark') {
      emit(
        const ThemeState(
          ThemeMode.dark,
        ),
      );
    } else {
      emit(
        const ThemeState(
          ThemeMode.light,
        ),
      );
    }
  }
}
