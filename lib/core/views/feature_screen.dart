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

class FeatureScreen extends ConsumerStatefulWidget {
  const FeatureScreen({super.key});

  @override
  _FeatureScreenState createState() => _FeatureScreenState();
}

class _FeatureScreenState extends ConsumerState<FeatureScreen> {
  String _searchQuery = "";
  List<Investment> _filteredInvestments = [];

  @override
  Widget build(BuildContext context) {
    final investmentData = ref.watch(investmentProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localize('investment_opportunities'),
          style: AppTextStyles.medium(size: 20, color: AppColors.white),
        ),
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.app,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                labelText: context.localize('search_investments'),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              style: AppTextStyles.regular(
                size: 16,
                color: AppColors.blackTitle,
              ),
              onChanged: (query) {
                setState(() => _searchQuery = query.toLowerCase());
              },
            ),
            SizedBox(height: 10),

            // Investment List
            Expanded(
              child: investmentData.when(
                loading: () => Center(child: CircularProgressIndicator()),
                error:
                    (error, stackTrace) => Center(
                      child: Text(
                        context.localize(
                          'error',
                          params: {"error": error.toString()},
                        ),
                        style: AppTextStyles.regular(
                          size: 16,
                          color: AppColors.blackTitle,
                        ),
                      ),
                    ),
                data: (investments) {
                  _filteredInvestments =
                      investments
                          .where(
                            (investment) => investment.name
                                .toLowerCase()
                                .contains(_searchQuery),
                          )
                          .toList();

                  if (_filteredInvestments.isEmpty) {
                    return Center(
                      child: Text(context.localize('no_investments_found')),
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
            ),
          ],
        ),
      ),
    );
  }
}
