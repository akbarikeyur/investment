import 'package:go_router/go_router.dart';
import 'package:investment/core/views/dashboard_screen.dart';
import 'package:investment/core/views/feature_screen.dart';
import 'package:investment/core/views/investment_detail_screen.dart';
import 'package:investment/core/views/login_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: Navigation.login.path,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: Navigation.dashboard.path,
      builder: (context, state) => DashboardScreen(),
    ),
    GoRoute(
      path: Navigation.feature.path,
      builder: (context, state) => FeatureScreen(),
    ),
    GoRoute(
      path: Navigation.investmentDetail.path,
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
        return "/LoginScreen";
      case dashboard:
        return "/DashboardScreen";
      case feature:
        return "/FeatureScreen";
      case investmentDetail:
        return "/InvestmentDetailScreen";
    }
  }
}
