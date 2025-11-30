import 'package:flutter/material.dart';

import '../presentation/auth/login_screen.dart';
import '../presentation/auth/register_screen.dart';
import '../presentation/auth/forgot_password_screen.dart';
import '../presentation/auth/terms_screen.dart';

import '../presentation/navigation/bottom_nav_screen.dart';
import '../presentation/porfile/profile_screen.dart';

class AppRoutes {
  static const login = "/login";
  static const register = "/register";
  static const forgot = "/forgot";
  static const terms = "/terms";
  static const nav = "/nav";
  static const profile = "/profile";

  static Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    forgot: (_) => const ForgotPasswordScreen(),
    terms: (_) => const TermsScreen(),

    // Pantalla principal després del login
    nav: (_) => const BottomNavScreen(),

    // Perfil
    profile: (_) => const ProfileScreen(),
  };
}
