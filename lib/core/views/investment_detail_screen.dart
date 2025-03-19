import 'package:flutter/material.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_extension.dart';
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
          context.localize('investment_details'),
          style: AppTextStyles.medium(size: 20, color: AppColors.white),
        ),
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.app,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
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
                  context.localize(
                    'roi',
                    params: {'roi': investment.roi.toString()},
                  ),
                  style: AppTextStyles.regular(size: 16),
                ),
                SizedBox(height: 5),
                Text(
                  context.localize(
                    'risk',
                    params: {'risk': investment.riskLevel},
                  ),
                  style: AppTextStyles.regular(size: 16),
                ),
                SizedBox(height: 5),
                Text(
                  context.localize(
                    'duration',
                    params: {'duration': investment.duration},
                  ),
                  style: AppTextStyles.regular(size: 16),
                ),
                SizedBox(height: 10),
                Text(
                  context.localize(
                    'investment_amount',
                    params: {'amount': investment.amount.toString()},
                  ),
                  style: AppTextStyles.bold(size: 18),
                ),
                SizedBox(height: 10),
                Text(
                  investment.longDescription,
                  style: AppTextStyles.regular(size: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
