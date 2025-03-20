import 'package:flutter_test/flutter_test.dart';
import 'package:investment/core/models/investment.dart';

void main() {
  late List<Investment> investments;

  setUp(() {
    investments = [
      Investment(
        id: "1",
        name: "Gold Investment",
        amount: 5000,
        roi: 10,
        riskLevel: "Low",
        description: "Gold Investment",
        duration: "5 Years",
        longDescription: 'Gold Investment long description',
      ),
      Investment(
        id: "2",
        name: "Stock Market",
        amount: 10000,
        roi: 15,
        riskLevel: "High",
        description: "Stocks",
        duration: "10 Years",
        longDescription: 'Stock Market long description',
      ),
      Investment(
        id: "3",
        name: "Real Estate",
        amount: 20000,
        roi: 8,
        riskLevel: "Medium",
        description: "Property",
        duration: "7 Years",
        longDescription: 'Real Estate long description',
      ),
    ];
  });

  test("Search should filter investments correctly", () {
    final query = "Gold".toLowerCase();
    final filtered =
        investments
            .where(
              (investment) => investment.name.toLowerCase().contains(query),
            )
            .toList();

    expect(filtered.length, 1);
    expect(filtered.first.name, "Gold Investment");
  });

  test("Search should return empty list if no match found", () {
    final query = "Crypto".toLowerCase();
    final filtered =
        investments
            .where(
              (investment) => investment.name.toLowerCase().contains(query),
            )
            .toList();

    expect(filtered.isEmpty, true);
  });
}
