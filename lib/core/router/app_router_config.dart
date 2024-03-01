import 'package:disaster_safety/core/presentation/pages/home_page.dart';
import 'package:disaster_safety/core/router/app_router_const.dart';
import 'package:disaster_safety/features/auth/presentation/pages/auth_landing_page.dart';
import 'package:disaster_safety/features/auth/presentation/pages/login_page.dart';
import 'package:disaster_safety/features/auth/presentation/pages/signup_page.dart';
import 'package:go_router/go_router.dart';

class AppRouterConfig {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      name: AppRouterConstants.authLandingName,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/login',
      name: AppRouterConstants.loginRouteName,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      name: AppRouterConstants.signupRouteName,
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: '/home',
      name: AppRouterConstants.homeRouteName,
      builder: (context, state) => HomePage(),
    ),
  ]);
}
