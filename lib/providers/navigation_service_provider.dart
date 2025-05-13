// lib/services/navigation_service.dart
import 'package:pretium_finance/intro_screens/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_finance/main.dart';
import 'package:pretium_finance/providers/auth.dart';
import 'package:pretium_finance/screens/authentication/forgot_password.dart';
import 'package:pretium_finance/screens/authentication/sign_in.dart';
import 'package:pretium_finance/screens/authentication/sign_up.dart';
import 'package:pretium_finance/screens/dashboard.dart';

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService(ref);
});

class NavigationService {
  final Ref _ref;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  NavigationService(this._ref);

  // Route names
  static const String splash = '/';
  static const String intro = '/intro';
  static const String login = '/login';
  static const String forgot = '/forgot';
  static const String register = '/register';
  static const String dashboard = '/dashboard';

  // Route generator
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(settings, const SplashScreen());
      case intro:
        return _buildRoute(settings, const IntroScreens());
      case login:
        return _buildRoute(settings, const LoginScreen());
      case register:
        return _buildRoute(settings, const SignUpScreen());
      case forgot:
        return _buildRoute(settings, const ForgotPasswordScreen());
      case dashboard:
        return _protectedRoute(settings, const DashboardScreen());
      default:
        return _buildRoute(
          settings,
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  Route<dynamic> _protectedRoute(RouteSettings settings, Widget page) {
    final user = _ref.read(userProvider);
    final isLoggedIn = user?.isLoggedIn ?? false;

    if (!isLoggedIn) {
      return _buildRoute(settings, const LoginScreen(), fullscreenDialog: true);
    }

    return _buildRoute(settings, page);
  }

  // Route builder with transitions
  Route<dynamic> _buildRoute(
    RouteSettings settings,
    Widget page, {
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
      fullscreenDialog: fullscreenDialog,
    );
  }
}
