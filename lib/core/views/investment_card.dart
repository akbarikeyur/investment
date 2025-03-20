import 'package:flutter/material.dart';
import 'package:investment/core/config/app_extension.dart';
import 'package:investment/core/config/app_textstyle.dart';
import 'package:investment/core/models/investment.dart';

/// A reusable investment card widget to display investment details.
/// [context] - The current BuildContext.
/// [investment] - The investment data to display.
/// [onPressed] - Optional tap callback for navigation or interaction.
Widget investmentCard(
  BuildContext context,
  Investment investment,
  VoidCallback? onPressed,
) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    elevation: 3, // Adds a subtle shadow effect for better UI
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Investment Name**
            Text(investment.name, style: AppTextStyles.bold(size: 18)),
            const SizedBox(height: 5),

            /// **Investment Description**
            Text(
              investment.description,
              style: AppTextStyles.regular(size: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // Ensures text doesn't overflow
            ),
            const SizedBox(height: 5),

            /// **ROI & Risk Level**
            Text(
              context.localize(
                'roi_risk',
                params: {
                  "roi": investment.roi.toString(),
                  "riskLevel": investment.riskLevel.toString(),
                },
              ),
              style: AppTextStyles.regular(size: 14),
            ),
            const SizedBox(height: 5),

            /// **Investment Duration**
            Text(
              context.localize(
                'duration',
                params: {'duration': investment.duration.toString()},
              ),
              style: AppTextStyles.regular(size: 14),
            ),
            const SizedBox(height: 10),

            /// **Investment Amount**
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "₹${investment.amount}",
                style: AppTextStyles.bold(size: 16, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
