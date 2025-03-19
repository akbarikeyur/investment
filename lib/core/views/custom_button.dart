import 'package:flutter/material.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_textstyle.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color bgColor;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.bgColor = AppColors.app,
    this.textColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Corner radius
        ),
        backgroundColor: bgColor,
      ),
      child: Text(title, style: AppTextStyles.bold(color: textColor, size: 16)),
    );
  }
}
