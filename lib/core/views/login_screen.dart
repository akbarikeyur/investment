import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investment/core/config/app_routes.dart';
import 'package:investment/core/services/biometric_auth_service.dart';

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
    _checkBiometricsLogin();
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
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: _loginWithBiometrics,
          child: Text('Login with Biometrics'),
        ),
      ),
    );
  }
}
