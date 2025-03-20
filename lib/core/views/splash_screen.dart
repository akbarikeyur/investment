import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_routes.dart';
import 'package:investment/core/config/app_textstyle.dart';
import 'package:investment/core/services/biometric_auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final BiometricAuthService _biometricAuthService = BiometricAuthService();

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3)); // Delay for 3 seconds
    if (mounted) {
      bool isAuthenticated = await _biometricAuthService.isUserAuthenticated();
      if (isAuthenticated) {
        context.go(Navigation.dashboard.path);
      } else {
        context.go(Navigation.login.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/app_logo.svg',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 10),
            Text(
              'I N V E S T M E N T',
              style: AppTextStyles.bold(size: 25, color: AppColors.app),
            ),
          ],
        ),
      ),
    );
  }
}
