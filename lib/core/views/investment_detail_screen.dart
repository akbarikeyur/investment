import 'package:flutter/material.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_textstyle.dart';
import 'package:investment/core/models/investment.dart';

class InvestmentDetailScreen extends StatelessWidget {
  final Investment investment;

  InvestmentDetailScreen(this.investment);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Investment Details",
          style: AppTextStyles.medium(size: 20, color: AppColors.white),
        ),
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.app,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(investment.name, style: AppTextStyles.bold(size: 22)),
            SizedBox(height: 10),
            Text(
              investment.description,
              style: AppTextStyles.regular(size: 16),
            ),
            SizedBox(height: 10),
            Text(
              "ROI: ${investment.roi}%",
              style: AppTextStyles.regular(size: 16),
            ),
            SizedBox(height: 5),
            Text(
              "Risk Level: ${investment.riskLevel}",
              style: AppTextStyles.regular(size: 16),
            ),
            SizedBox(height: 5),
            Text(
              "Duration: ${investment.duration}",
              style: AppTextStyles.regular(size: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Investment Amount: ₹${investment.amount}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
