import 'package:dio/dio.dart';
import 'package:investment/core/config/app_utility.dart';
import 'package:investment/core/models/investment.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Investment>> fetchInvestmentData() async {
    final jsonList = await fetchDataFromJson();
    return jsonList.map((json) => Investment.fromJson(json)).toList();
  }
}
