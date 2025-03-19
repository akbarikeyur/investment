import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investment/core/models/investment.dart';
import 'package:investment/core/services/api_service.dart';

final investmentProvider = FutureProvider<List<Investment>>((ref) async {
  final apiService = ApiService();
  final data = await apiService.fetchInvestmentData();
  return data.map((item) => Investment.fromJson(item)).toList();
});
