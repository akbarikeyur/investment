import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:investment/core/models/investment.dart';

Future<List<dynamic>> fetchDataFromJson() async {
  // Load the JSON file
  final String jsonString = await rootBundle.loadString(
    'assets/json/investment_data.json',
  );

  // Parse the JSON into a List
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList;
}
