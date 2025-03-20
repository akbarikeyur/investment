import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_extension.dart';
import 'package:investment/core/config/app_routes.dart';
import 'package:investment/core/config/app_textstyle.dart';
import 'package:investment/core/models/investment.dart';
import 'package:investment/core/viewmodels/auth_viewmodel.dart';
import 'package:investment/core/viewmodels/dashboard_viewmodel.dart';
import 'package:investment/widgets/custom_button.dart';
import 'package:investment/core/views/investment_card.dart';

/// DashboardScreen displays user investments and key statistics.
/// Uses Riverpod to manage state and data fetching.
class DashboardScreen extends ConsumerWidget {
  final String userName = "Keyur Akbari";

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final investmentData = ref.watch(dashboardProvider);
    final authViewModel = ref.read(authViewModelProvider);

    return Scaffold(
      appBar: _buildAppBar(context, authViewModel),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Welcome Message
            Text(
              context.localize(
                'welcome_message',
                params: {'userName': userName},
              ),
              style: AppTextStyles.bold(size: 22),
            ),
            const SizedBox(height: 10),

            /// Investment Data Handling (Loading, Error, Success)
            investmentData.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (error, stackTrace) => Center(
                    child: Text(
                      context.localize(
                        'error_loading_investments',
                        params: {'error': error.toString()},
                      ),

                      style: AppTextStyles.medium(size: 16, color: Colors.red),
                    ),
                  ),
              data:
                  (investments) =>
                      _buildInvestmentSection(context, investments),
            ),

            /// Button to View All Investments
            CustomButton(
              title: context.localize('see_all_investment'),
              onPressed: () => context.push(Navigation.feature.path),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the App Bar with Logout functionality
  AppBar _buildAppBar(BuildContext context, AuthViewModel authViewModel) {
    return AppBar(
      title: Text(
        context.localize('dashboard'),
        style: AppTextStyles.medium(size: 20, color: AppColors.white),
      ),
      backgroundColor: AppColors.app,
      actions: [
        IconButton(
          onPressed: () async {
            await authViewModel.logout();
            if (context.mounted) {
              context.go(Navigation.login.path);
            }
          },
          icon: const Icon(Icons.logout, color: AppColors.white),
        ),
      ],
    );
  }

  /// Builds the investment summary and top investments section.
  Widget _buildInvestmentSection(
    BuildContext context,
    List<Investment> investments,
  ) {
    // Sort investments by amount in descending order and take top 3
    investments.sort((a, b) => b.amount.compareTo(a.amount));
    final topInvestments = investments.take(3).toList();

    return Expanded(
      child: Column(
        children: [
          /// Investment Summary Cards
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
          const SizedBox(height: 20),

          /// Top Investment Opportunities
          Text(
            context.localize('top_investment_opportunities'),
            style: AppTextStyles.bold(size: 18),
          ),
          const SizedBox(height: 10),

          /// List of Top 3 Investments
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
  }

  /// Builds a summary card for investment statistics.
  Widget _summaryCard(String title, String value) {
    return Expanded(
      child: Card(
        color: AppColors.app,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              /// Ensures the text adjusts to available space
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: AppTextStyles.bold(size: 20, color: AppColors.white),
                ),
              ),
              const SizedBox(height: 5),

              /// Title of the summary
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

  /// Calculates the total investment amount.
  int _calculateTotalInvestment(List<Investment> investments) {
    return investments.fold(0, (sum, investment) => sum + investment.amount);
  }
}
