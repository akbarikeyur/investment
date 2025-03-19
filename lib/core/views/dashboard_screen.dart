import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_extension.dart';
import 'package:investment/core/config/app_routes.dart';
import 'package:investment/core/config/app_textstyle.dart';
import 'package:investment/core/models/investment.dart';
import 'package:investment/core/viewmodels/dashboard_viewmodel.dart';
import 'package:investment/core/views/custom_button.dart';
import 'package:investment/core/views/investment_card.dart';

class DashboardScreen extends ConsumerWidget {
  final String userName = "Keyur Akbari";

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final investmentData = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localize('dashboard'),
          style: AppTextStyles.medium(size: 20, color: AppColors.white),
        ),
        backgroundColor: AppColors.app,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localize(
                'welcome_message',
                params: {'userName': userName},
              ),
              style: AppTextStyles.bold(size: 22),
            ),
            SizedBox(height: 10),

            investmentData.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error:
                  (error, stackTrace) => Center(child: Text("Error: $error")),
              data: (investments) {
                investments.sort((a, b) => b.amount.compareTo(a.amount));
                final topInvestments = investments.take(3).toList();

                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _summaryCard(
                            context.localize('total_investments'),
                            "${investments.length}",
                          ),
                          _summaryCard(
                            context.localize('total_value'),
                            "₹${_calculateTotalInvestment(investments)}",
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        context.localize('top_investment_opportunities'),
                        style: AppTextStyles.bold(size: 18),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: topInvestments.length,
                          itemBuilder: (context, index) {
                            final investment = topInvestments[index];
                            return investmentCard(context, investment, null);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            CustomButton(
              title: context.localize('see_all_investment'),
              onPressed: () {
                context.push(Navigation.feature.path);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String title, String value) {
    return Expanded(
      child: Card(
        color: AppColors.app,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                value,
                style: AppTextStyles.bold(size: 20, color: AppColors.white),
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: AppTextStyles.medium(size: 16, color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateTotalInvestment(List<Investment> investments) {
    return investments.fold(0, (sum, investment) => sum + investment.amount);
  }
}
