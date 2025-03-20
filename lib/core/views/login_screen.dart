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

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final BiometricAuthService _biometricAuthService = BiometricAuthService();
  final pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _loginWithBiometrics() async {
    final authenticated = await _biometricAuthService.authenticateUser();
    if (authenticated) {
      if (mounted) {
        context.go(Navigation.dashboard.path);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.localize('authentication_failed'))),
      );
    }
  }

  void _loginWithPin() async {
    final authViewModel = ref.read(authViewModelProvider);
    final pin = pinController.text;

    if (pin.length == 4) {
      await authViewModel.login(pin);
      final isAuthenticated = await authViewModel.isAuthenticated();
      if (isAuthenticated) {
        if (mounted) {
          context.go(Navigation.dashboard.path);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.localize('authentication_failed'))),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid 4-digit PIN")),
      );
    }
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
            buildPinTextField(pinController),
            const SizedBox(height: 20),
            CustomButton(
              title: context.localize('login_button'),
              onPressed: _loginWithPin, // Updated to login with PIN
            ),
            const SizedBox(height: 10),
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
