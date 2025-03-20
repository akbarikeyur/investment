import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:investment/core/services/secure_storage_service.dart';

final authViewModelProvider = ChangeNotifierProvider((ref) => AuthViewModel());

class AuthViewModel extends ChangeNotifier {
  final SecureStorageService _storageService = SecureStorageService();

  Future<void> login(String pin) async {
    if (pin == "2025") {
      await _storageService.writeSecureData('isAuthenticated', 'true');
      notifyListeners();
    }
  }

  Future<bool> isAuthenticated() async {
    final isAuthenticated = await _storageService.readSecureData(
      'isAuthenticated',
    );
    return isAuthenticated != null;
  }

  Future<void> logout() async {
    await _storageService.deleteSecureData('isAuthenticated');
    notifyListeners();
  }
}
