import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investment/core/models/investment.dart';
import 'package:investment/core/viewmodels/investment_viewmodel.dart';
import 'package:investment/core/views/investment_detail_screen.dart';

class FeatureScreen extends ConsumerStatefulWidget {
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
        title: Text("Investment Opportunities"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                labelText: "Search Investments",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
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
                    (error, stackTrace) => Center(child: Text("Error: $error")),
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
                    return Center(child: Text("No investments found"));
                  }

                  return ListView.builder(
                    itemCount: _filteredInvestments.length,
                    itemBuilder: (context, index) {
                      final investment = _filteredInvestments[index];
                      return _investmentCard(context, investment);
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

  // Investment Card Widget
  Widget _investmentCard(BuildContext context, Investment investment) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          investment.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(investment.description),
            Text("ROI: ${investment.roi}%  •  Risk: ${investment.riskLevel}"),
            Text("Duration: ${investment.duration}"),
          ],
        ),
        trailing: Text(
          "₹${investment.amount}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InvestmentDetailScreen(investment),
            ),
          );
        },
      ),
    );
  }
}
