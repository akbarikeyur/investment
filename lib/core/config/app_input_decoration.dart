import 'package:flutter/material.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_textstyle.dart';

class AppInputDecoration {
  static InputDecoration getInputDecoration({
    required String labelText,
    String? errorText,
    double? borderRadius = 5.0,
    Color? borderColor = AppColors.greyBorder,
    Color? focusedBorderColor = AppColors.blackTitle,
    double? focusedBorderWidth = 2.0,
    Color? errorBorderColor = AppColors.error,
  }) {
    return InputDecoration(
      hintText: labelText,
      hintStyle: AppTextStyles.regular(
        size: 16,
        color: AppColors.greyPlaceholder,
      ),
      errorText: errorText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      alignLabelWithHint: true, // Ensures the label aligns with hint text
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius!),
        borderSide: BorderSide(color: borderColor!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius!),
        borderSide: BorderSide(color: borderColor!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: focusedBorderColor!),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: errorBorderColor!),
      ),
    );
  }
}
