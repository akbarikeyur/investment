import 'package:go_router/go_router.dart';
import 'package:investment/core/services/secure_storage_service.dart';
import 'package:investment/core/views/dashboard_screen.dart';
import 'package:investment/core/views/feature_screen.dart';
import 'package:investment/core/views/investment_detail_screen.dart';
import 'package:investment/core/views/login_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: Navigation.login.path,
      name: Navigation.login.toString(),
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: Navigation.dashboard.path,
      name: Navigation.dashboard.toString(),
      builder: (context, state) => DashboardScreen(),
    ),
    GoRoute(
      path: Navigation.feature.path,
      name: Navigation.feature.toString(),
      builder: (context, state) => FeatureScreen(),
    ),
    GoRoute(
      path: Navigation.investmentDetail.path,
      name: Navigation.investmentDetail.toString(),
      builder: (context, state) {
        final Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;
        return InvestmentDetailScreen(data?['investment']);
      },
    ),
  ],
);

enum Navigation {
  login,
  dashboard,
  feature,
  investmentDetail;

  String get path {
    switch (this) {
      case login:
        return "/";
      case dashboard:
        return "/DashboardScreen";
      case feature:
        return "/FeatureScreen";
      case investmentDetail:
        return "/InvestmentDetailScreen";
    }
  }
}
