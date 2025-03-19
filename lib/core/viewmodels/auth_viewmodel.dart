import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investment/core/services/secure_storage_service.dart';

final authViweModelProvider = ChangeNotifierProvider((ref) => AuthViewmodel());

class AuthViewmodel extends ChangeNotifier {
  final SecureStorageService _storageService = SecureStorageService();

  Future<void> login(String pin) async {
    //Simulating authentication
    if (pin == "2025") {
      await _storageService.writeSecureData('token', 'secure_token');
    }
  }

  Future<bool> isAuthenticated() async {
    final token = _storageService.readSecureData('token');
    return token != null;
  }

  Future<void> logout() async {
    await _storageService.deleteSecureData('token');
  }
}
