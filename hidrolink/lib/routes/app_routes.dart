import 'package:flutter/material.dart';
import '../presentation/auth/login_screen.dart';
import '../presentation/auth/register_screen.dart';
import '../presentation/dashboard/dashboard_screen.dart';
import '../presentation/auth/forgot_password_screen.dart';

class AppRoutes {
  static const login = "/login";
  static const register = "/register";
  static const dashboard = "/dashboard";
  static const forgot = "/forgot";

  static Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    dashboard: (_) => const DashboardScreen(),
    forgot: (_) => const ForgotPasswordScreen(),
  };
}
