import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';
import '../../routes/app_routes.dart';
import '../widgets/app_input_field.dart';
import '../widgets/app_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool loading = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logo.png', height: 150),

              const SizedBox(height: 30),

              const Text(
                "Iniciar Sessió",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 32),

              AppInputField(
                controller: email,
                label: "Correu electrònic",
                icon: Icons.email,
              ),

              const SizedBox(height: 16),

              TextField(
                controller: password,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: "Contrasenya",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => showPassword = !showPassword);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              AppButton(
                text: "Entrar",
                icon: Icons.login,
                loading: loading,
                onPressed: login,
              ),

              const SizedBox(height: 8),

              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.register),
                child: const Text("No tens compte? Registra't"),
              ),

              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.forgot),
                child: const Text("Has oblidat la contrasenya?"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      return _error("Omple tots els camps");
    }

    setState(() => loading = true);

    final res = await AuthService.login(email.text, password.text);

    setState(() => loading = false);

    if (res == true) {
      Navigator.pushReplacementNamed(context, "/nav");
    } else {
      _error(res.toString());
    }
  }

  void _error(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
