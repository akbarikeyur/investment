import 'package:go_router/go_router.dart';
import 'package:investment/core/views/dashboard_screen.dart';
import 'package:investment/core/views/feature_screen.dart';
import 'package:investment/core/views/investment_detail_screen.dart';
import 'package:investment/core/views/investment_pdf_screen.dart';
import 'package:investment/core/views/login_screen.dart';
import 'package:investment/core/views/splash_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: Navigation.splash.path,
      name: Navigation.splash.toString(),
      builder: (context, state) => SplashScreen(),
    ),
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
    GoRoute(
      path: Navigation.investmentPdf.path,
      name: Navigation.investmentPdf.toString(),
      builder: (context, state) {
        final Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;
        return InvestmentPDFScreen(investment: data?['investment']);
      },
    ),
  ],
);

enum Navigation {
  splash,
  login,
  dashboard,
  feature,
  investmentDetail,
  investmentPdf;

  String get path {
    switch (this) {
      case login:
        return "/login";
      case dashboard:
        return "/DashboardScreen";
      case feature:
        return "/FeatureScreen";
      case investmentDetail:
        return "/InvestmentDetailScreen";
      case investmentPdf:
        return "/InvestmentPDFScreen";
      case splash:
        return "/";
    }
  }
}
