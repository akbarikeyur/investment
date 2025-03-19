import 'package:investment/core/services/secure_storage_service.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  final SecureStorageService _secureStorageService = SecureStorageService();

  //Check if device support biometrics
  Future<bool> isBiometricsAvailalble() async {
    return await _localAuthentication.canCheckBiometrics;
  }

  //Get list of avaialble biometrics
  Future<List<BiometricType>> getAvaialbleBiometricsList() async {
    return _localAuthentication.getAvailableBiometrics();
  }

  //Authenticate user
  Future<bool> authenticateUser() async {
    bool isAuthenticated = false;

    try {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: "Authenticate to access your account",
        options: AuthenticationOptions(biometricOnly: true, stickyAuth: true),
      );

      //Save authentication status securely
      if (isAuthenticated) {
        await _secureStorageService.writeSecureData("isAuthenticated", "true");
      }
    } catch (e) {
      print("Authenticate Error: $e");
    }

    return isAuthenticated;
  }

  //Check if user already authenticated
  Future<bool> isUserAuthenticated() async {
    String? status = await _secureStorageService.readSecureData(
      'isAuthenticated',
    );
    return status != null;
  }
}
