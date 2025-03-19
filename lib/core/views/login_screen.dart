import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_routes.dart';
import 'package:investment/core/config/app_textstyle.dart';
import 'package:investment/core/services/biometric_auth_service.dart';
import 'package:investment/core/views/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final BiometricAuthService _biometricAuthService = BiometricAuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _checkBiometricsLogin();
  }

  void _checkBiometricsLogin() async {
    bool _isAuthenticated = await _biometricAuthService.isUserAuthenticated();
    if (_isAuthenticated) {
      context.pushReplacementNamed(Navigation.dashboard.path);
    }
  }

  void _loginWithBiometrics() async {
    bool authenticated = await _biometricAuthService.authenticateUser();
    if (authenticated) {
      context.pushReplacementNamed(Navigation.dashboard.path);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Authentication Failed')));
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
            SvgPicture.asset(
              'images/face_scan.svg',
              width: 70,
              height: 70,
              colorFilter: ColorFilter.mode(AppColors.app, BlendMode.srcIn),
            ),
            SizedBox(height: 10),
            Text(
              'Login with Biometrics',
              style: AppTextStyles.bold(size: 22, color: AppColors.blackTitle),
            ),
            SizedBox(height: 5),
            Text(
              'Unlock your account with just a glance or a touch. Say goodbye to password and simplify your sign-in.',
              style: AppTextStyles.regular(
                size: 16,
                color: AppColors.greyTitle,
              ),
            ),
            SizedBox(height: 100),
            CustomButton(title: 'Login', onPressed: _loginWithBiometrics),
          ],
        ),
      ),
    );
  }
}
