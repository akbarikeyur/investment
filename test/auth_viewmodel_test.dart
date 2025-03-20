import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:investment/core/services/biometric_auth_service.dart';
import 'package:investment/core/viewmodels/auth_viewmodel.dart';

class MockBiometricAuthService extends Mock implements BiometricAuthService {}

void main() {
  late AuthViewModel authViewModel;
  late MockBiometricAuthService mockBiometricAuthService;

  setUp(() {
    mockBiometricAuthService = MockBiometricAuthService();
    authViewModel = AuthViewModel();
  });

  test("Login with correct PIN should authenticate user", () async {
    await authViewModel.login("2025");
    expect(await authViewModel.isAuthenticated(), true);
  });

  test("Login with incorrect PIN should not authenticate user", () async {
    await authViewModel.login("1111");
    expect(await authViewModel.isAuthenticated(), false);
  });

  test("Biometric authentication should work", () async {
    when(
      mockBiometricAuthService.authenticateUser(),
    ).thenAnswer((_) async => true);
    final result = await mockBiometricAuthService.authenticateUser();
    expect(result, true);
  });

  test("Biometric authentication should fail", () async {
    when(
      mockBiometricAuthService.authenticateUser(),
    ).thenAnswer((_) async => false);
    final result = await mockBiometricAuthService.authenticateUser();
    expect(result, false);
  });
}
