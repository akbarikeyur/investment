import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_extension.dart';
import 'package:investment/core/config/app_routes.dart';
import 'package:investment/core/config/app_textstyle.dart';
import 'package:investment/core/services/biometric_auth_service.dart';
import 'package:investment/core/viewmodels/auth_viewmodel.dart';
import 'package:investment/widgets/custom_button.dart';
import 'package:investment/widgets/custom_textfield.dart';

/// LoginScreen handles user authentication using PIN or biometrics.
/// Utilizes Riverpod for state management.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final BiometricAuthService _biometricAuthService = BiometricAuthService();
  final TextEditingController pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  /// Authenticates the user using biometric authentication.
  Future<void> _loginWithBiometrics() async {
    try {
      final authenticated = await _biometricAuthService.authenticateUser();
      if (authenticated && mounted) {
        context.go(Navigation.dashboard.path);
      } else {
        _showSnackBar(context.localize('authentication_failed'));
      }
    } catch (e) {
      debugPrint("Biometric Authentication Error: $e");
      _showSnackBar(context.localize('authentication_failed'));
    }
  }

  /// Authenticates the user using a 4-digit PIN.
  Future<void> _loginWithPin() async {
    final authViewModel = ref.read(authViewModelProvider);
    final pin = pinController.text.trim();

    if (pin.length != 4) {
      _showSnackBar(context.localize('enter_valid_pin'));
      return;
    }

    try {
      await authViewModel.login(pin);
      final isAuthenticated = await authViewModel.isAuthenticated();

      if (isAuthenticated && mounted) {
        context.go(Navigation.dashboard.path);
      } else {
        _showSnackBar(context.localize('authentication_failed'));
      }
    } catch (e) {
      debugPrint("PIN Authentication Error: $e");
      _showSnackBar(context.localize('authentication_failed'));
    }
  }

  /// Shows a SnackBar with a given message.
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// App Logo and Title
            Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/app_logo.svg',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'I N V E S T M E N T',
                    style: AppTextStyles.bold(size: 25, color: AppColors.app),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            /// PIN Input Field
            buildPinTextField(pinController),
            const SizedBox(height: 20),

            /// Login Button (PIN)
            CustomButton(
              title: context.localize('login_button'),
              onPressed: _loginWithPin,
            ),
            const SizedBox(height: 10),

            /// Biometric Login Button
            CustomButton(
              isOutlined: true,
              icon: Icon(Icons.fingerprint, color: AppColors.app, size: 30),
              borderColor: AppColors.app,
              bgColor: AppColors.white,
              textColor: AppColors.app,
              title: context.localize('login_with_biometrics'),
              onPressed: _loginWithBiometrics,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
