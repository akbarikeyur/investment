import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_extension.dart';
import 'package:investment/core/config/app_routes.dart';
import 'package:investment/core/config/app_textstyle.dart';
import 'package:investment/core/models/investment.dart';
import 'package:investment/core/viewmodels/investment_viewmodel.dart';
import 'package:investment/core/views/investment_card.dart';
import 'dart:async'; // Required for debounce

/// FeatureScreen displays a searchable list of investment opportunities.
class FeatureScreen extends ConsumerStatefulWidget {
  const FeatureScreen({super.key});

  @override
  _FeatureScreenState createState() => _FeatureScreenState();
}

class _FeatureScreenState extends ConsumerState<FeatureScreen> {
  String _searchQuery = "";
  List<Investment> _filteredInvestments = [];
  Timer? _debounce; // Timer for search optimization

  @override
  void dispose() {
    _debounce?.cancel(); // Cancel debounce timer when widget is disposed
    super.dispose();
  }

  /// Handles search input with a debounce mechanism
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() => _searchQuery = query.toLowerCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    final investmentData = ref.watch(investmentProvider);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(context),
            const SizedBox(height: 10),
            _buildInvestmentList(investmentData, context),
          ],
        ),
      ),
    );
  }

  /// Builds the app bar with a title.
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        context.localize('investment_opportunities'),
        style: AppTextStyles.medium(size: 20, color: AppColors.white),
      ),
      iconTheme: IconThemeData(color: AppColors.white),
      backgroundColor: AppColors.app,
    );
  }

  /// Builds the search bar for filtering investments.
  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: context.localize('search_investments'),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      style: AppTextStyles.regular(size: 16, color: AppColors.blackTitle),
      onChanged: _onSearchChanged, // Uses debounce function
    );
  }

  /// Builds the investment list based on fetched data.
  Widget _buildInvestmentList(
    AsyncValue<List<Investment>> investmentData,
    BuildContext context,
  ) {
    return Expanded(
      child: investmentData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _buildErrorWidget(context, error),
        data: (investments) {
          _filteredInvestments =
              investments
                  .where(
                    (investment) =>
                        investment.name.toLowerCase().contains(_searchQuery),
                  )
                  .toList();

          if (_filteredInvestments.isEmpty) {
            return Center(
              child: Text(
                context.localize('no_investments_found'),
                style: AppTextStyles.medium(
                  size: 16,
                  color: AppColors.blackTitle,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: _filteredInvestments.length,
            itemBuilder: (context, index) {
              final investment = _filteredInvestments[index];
              return investmentCard(context, investment, () {
                context.push(
                  Navigation.investmentDetail.path,
                  extra: {'investment': investment},
                );
              });
            },
          );
        },
      ),
    );
  }

  /// Displays an error message when fetching investments fails.
  Widget _buildErrorWidget(BuildContext context, Object error) {
    return Center(
      child: Text(
        context.localize('error', params: {"error": error.toString()}),
        style: AppTextStyles.regular(size: 16, color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }
}
