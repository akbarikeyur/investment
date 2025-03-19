import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investment/core/services/secure_storage_service.dart';

final authViewModelProvider = ChangeNotifierProvider((ref) => AuthViewModel());

class AuthViewModel extends ChangeNotifier {
  final SecureStorageService _storageService = SecureStorageService();

  Future<void> login(String pin) async {
    if (pin == "2025") {
      await _storageService.writeSecureData('token', 'secure_token');
      notifyListeners();
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await _storageService.readSecureData('token');
    return token != null;
  }

  Future<void> logout() async {
    await _storageService.deleteSecureData('token');
    notifyListeners();
  }
}
