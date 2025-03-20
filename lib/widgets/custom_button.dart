import 'package:flutter/material.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_textstyle.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color bgColor;
  final Color textColor;
  final bool isOutlined;
  final Color? borderColor;
  final double? borderCorner;
  final Widget? icon;
  final bool? isIconBeforeText;

  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.bgColor = AppColors.app,
    this.textColor = AppColors.white,
    this.isOutlined = false,
    this.borderColor = AppColors.app,
    this.borderCorner = 10,
    this.icon,
    this.isIconBeforeText = true,
  });

  @override
  Widget build(BuildContext context) {
    return isOutlined
        ? OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderCorner!,
              ), // Corner radius
            ),
            side: BorderSide(color: borderColor!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:
                (isIconBeforeText ?? false)
                    ? [
                      icon ?? SizedBox.shrink(),
                      SizedBox(width: 8),
                      Text(
                        title,
                        style: AppTextStyles.bold(size: 16, color: textColor),
                      ),
                    ]
                    : [
                      Text(
                        title,
                        style: AppTextStyles.bold(
                          size: 16,
                          color: AppColors.blackTitle,
                        ),
                      ),
                      SizedBox(width: 8),
                      icon ?? SizedBox.shrink(),
                    ],
          ),
        )
        : ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Corner radius
            ),
            backgroundColor: bgColor,
          ),
          child: Text(
            title,
            style: AppTextStyles.bold(color: textColor, size: 16),
          ),
        );
  }
}
