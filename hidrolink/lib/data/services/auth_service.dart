import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final _supabase = Supabase.instance.client;

  static Future login(String email, String password) async {
    try {
      final res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return res.user != null ? true : "Error d'autenticació";
    } catch (e) {
      return e.toString();
    }
  }

  static Future register(
    String email,
    String password,
    String name
  ) async {
    try {
      final res = await _supabase.auth.signUp(email: email, password: password);

      if (res.user == null) return "Error en registrar";

      // Assignar el nom complet
      await _supabase.auth.updateUser(
        UserAttributes(data: {'display_name': name}),
      );

      return true;
    } catch (e) {
      return e.toString();
    }
  }

  static Future resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      return "Correu enviat correctament!";
    } catch (e) {
      return e.toString();
    }
  }
}
