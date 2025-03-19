import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investment/core/models/investment.dart';
import 'package:investment/core/services/api_service.dart';

// Riverpod Provider for API
final dashboardProvider = FutureProvider<List<Investment>>((ref) async {
  final apiService = ApiService();
  return await apiService.fetchInvestmentData();
});
