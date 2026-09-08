import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:platinum_app/core/theming/colors.dart';
import 'package:platinum_app/core/theming/theme_extension.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText ?? false,
      style: inputTextStyle ??
          TextStyle(
            color: context.textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
      decoration: InputDecoration(
        isDense: true,

        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 18.h,
            ),

// =========================
// FOCUSED
// =========================

        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.mainBlue,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16),
            ),

// =========================
// ENABLED
// =========================

        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: context.isDark
                    ? Colors.white.withOpacity(.10)
                    : ColorsManager.lighterGray,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16),
            ),

// =========================
// ERROR
// =========================

        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16),
        ),

// =========================
// HINT
// =========================

        hintStyle: hintStyle ??
            TextStyle(
              color: context.subTextColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),

        hintText: hintText,

// =========================
// SUFFIX
// =========================

        suffixIcon: suffixIcon,

// =========================
// BACKGROUND
// =========================

        fillColor: backgroundColor ?? context.cardColor,
        filled: true,
      ),
      validator: (value) {
        return validator(value);
      },
    );
  }
}
