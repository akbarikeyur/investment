import 'package:flutter/material.dart';
import 'package:investment/core/config/app_textstyle.dart';
import 'package:investment/core/models/investment.dart';

Widget investmentCard(
  BuildContext context,
  Investment investment,
  VoidCallback onPressed,
) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: ListTile(
      title: Text(investment.name, style: AppTextStyles.bold(size: 16)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(investment.description, style: AppTextStyles.regular(size: 16)),
          Text(
            "ROI: ${investment.roi}%  •  Risk: ${investment.riskLevel}",
            style: AppTextStyles.regular(size: 16),
          ),
          Text(
            "Duration: ${investment.duration}",
            style: AppTextStyles.regular(size: 16),
          ),
        ],
      ),
      trailing: Text(
        "₹${investment.amount}",
        style: AppTextStyles.bold(size: 16),
      ),
      onTap: onPressed,
    ),
  );
}
