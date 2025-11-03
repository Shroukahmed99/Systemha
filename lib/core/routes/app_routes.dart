import 'package:flutter/material.dart';
import 'package:systemha/core/routes/base_routes.dart';
import 'package:systemha/features/auth/Presentation/views/login_view.dart';
import 'package:systemha/features/auth/Presentation/views/reset_password_view.dart';
import 'package:systemha/features/auth/Presentation/views/sign_up_view%20.dart';
import 'package:systemha/features/splash/Presentation/views/splash_view.dart';

class AppRoutes {
    static const String splash = '/';
  static const String login = 'login';
  static const String signUp = 'signUp';
  static const String resetPassword = 'resetPassword';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case splash:
        return BaseRoute(page: const SplashView());

      
      case login:
        return BaseRoute(
          page: const LoginView(),
        );
      

      case signUp:
        return BaseRoute(
          page: const SignUpView(),
        );

        case resetPassword:
        return BaseRoute(
          page: const ResetPasswordView(),
        );

      default:
        return BaseRoute(
          page: const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
