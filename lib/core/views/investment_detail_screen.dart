import 'package:flutter/material.dart';
import 'package:investment/core/models/investment.dart';

class InvestmentDetailScreen extends StatelessWidget {
  final Investment investment;

  InvestmentDetailScreen(this.investment);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(investment.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              investment.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(investment.description),
            SizedBox(height: 10),
            Text("ROI: ${investment.roi}%"),
            Text("Risk Level: ${investment.riskLevel}"),
            Text("Duration: ${investment.duration}"),
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
