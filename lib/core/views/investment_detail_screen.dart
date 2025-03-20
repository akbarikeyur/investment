import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_extension.dart';
import 'package:investment/core/config/app_routes.dart';
import 'package:investment/core/config/app_textstyle.dart';
import 'package:investment/core/models/investment.dart';

/// Screen to display detailed information about an investment
class InvestmentDetailScreen extends StatelessWidget {
  final Investment investment;

  /// Constructor requires an investment object
  const InvestmentDetailScreen(this.investment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localize('investment_details'),
          style: AppTextStyles.medium(size: 20, color: AppColors.white),
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.app,
        actions: [
          /// PDF Download Button
          IconButton(
            onPressed: () {
              context.push(
                Navigation.investmentPdf.path,
                extra: {'investment': investment},
              );
            },
            icon: const Icon(Icons.picture_as_pdf, size: 24),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            /// **Investment Name**
            Text(investment.name, style: AppTextStyles.bold(size: 22)),
            const SizedBox(height: 10),

            /// **Investment Description**
            Text(
              investment.description,
              style: AppTextStyles.regular(size: 16),
            ),
            const Divider(height: 20, thickness: 1),

            /// **ROI (Return on Investment)**
            _infoRow(
              context,
              title: context.localize('roi'),
              value: "${investment.roi}%",
            ),

            /// **Risk Level**
            _infoRow(
              context,
              title: context.localize('risk'),
              value: investment.riskLevel.toString(),
            ),

            /// **Investment Duration**
            _infoRow(
              context,
              title: context.localize('duration'),
              value: investment.duration.toString(),
            ),

            /// **Investment Amount**
            _infoRow(
              context,
              title: context.localize('investment_amount'),
              value: "₹${investment.amount}",
              isBold: true,
            ),

            const SizedBox(height: 15),

            /// **Detailed Investment Information**
            Text(
              investment.longDescription,
              style: AppTextStyles.regular(size: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  /// **Helper method to create a structured information row**
  Widget _infoRow(
    BuildContext context, {
    required String title,
    required String value,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.regular(size: 16, color: AppColors.blackTitle),
          ),
          Text(
            value,
            style:
                isBold
                    ? AppTextStyles.bold(size: 16, color: AppColors.app)
                    : AppTextStyles.regular(size: 16),
          ),
        ],
      ),
    );
  }
}
