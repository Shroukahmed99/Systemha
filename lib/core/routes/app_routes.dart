import 'package:flutter/material.dart';
import 'package:systemha/core/routes/base_routes.dart';
import 'package:systemha/features/splash/Presentation/views/onboarding.dart';
import 'package:systemha/features/splash/Presentation/views/splash_view.dart';

class AppRoutes {
    static const String splash = '/';
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String signUp = 'signUp';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case splash:
        return BaseRoute(page: const SplashView());

      case onboarding:
        return BaseRoute(page: const Onboarding());

      // case login:
      //   return BaseRoute(
      //     page: const LoginScreen(),
      //   );
      

      // case signUp:
      //   return BaseRoute(
      //     page: const SignUpScreen(),
      //   );

      default:
        return BaseRoute(
          page: const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
