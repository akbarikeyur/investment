import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investment/core/viewmodels/investment_viewmodel.dart';

class InvestmentScreen extends ConsumerWidget {
  const InvestmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final investmentAsync = ref.watch(investmentProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Investments')),
      body: investmentAsync.when(
        data:
            (investments) => ListView.builder(
              itemCount: investments.length,
              itemBuilder: (context, index) {
                final investment = investments[index];
                return ListTile(
                  title: Text(investment.name),
                  subtitle: Text("\$${investment.amount}"),
                );
              },
            ),
        error: (e, _) => Center(child: Text('Error Loading data')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
