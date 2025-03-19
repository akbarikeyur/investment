import 'package:go_router/go_router.dart';
import 'package:investment/core/views/dashboard_screen.dart';
import 'package:investment/core/views/feature_screen.dart';
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
  ],
);

enum Navigation {
  login,
  dashboard,
  feature;

  String get path {
    switch (this) {
      case login:
        return "/LoginScreen";
      case dashboard:
        return "/";
        return "/DashboardScreen";
      case feature:
        return "/FeatureScreen";
    }
  }
}
