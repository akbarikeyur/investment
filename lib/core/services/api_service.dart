import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchInvestmentData() async {
    final response = await _dio.get('https://api.example.com/investment');
    return response.data;
  }
}
