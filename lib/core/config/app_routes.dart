import 'package:go_router/go_router.dart';
import 'package:investment/core/views/dashboard_screen.dart';
import 'package:investment/core/views/investment_screen.dart';
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
      path: Navigation.investment.path,
      builder: (context, state) => InvestmentScreen(),
    ),
  ],
);

enum Navigation {
  login,
  dashboard,
  investment;

  String get path {
    switch (this) {
      case login:
        return "/";
      case dashboard:
        return "/dashboard";
      case investment:
        return "/investment";
    }
  }
}
