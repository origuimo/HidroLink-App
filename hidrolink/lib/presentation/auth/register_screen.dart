import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';
import '../../routes/app_routes.dart';
import '../widgets/app_input_field.dart';
import '../widgets/app_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final repeat = TextEditingController();
  final name = TextEditingController();

  bool showPassword = false;
  bool loading = false;
  bool acceptTerms = false;

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
                "Crear Compte",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 32),
              // NAME
              AppInputField(
                controller: name,
                label: "Nom i cognoms",
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              // EMAIL
              AppInputField(
                controller: email,
                label: "Correu electrònic",
                icon: Icons.email,
              ),
              const SizedBox(height: 16),

              // PASSWORD
              TextField(
                controller: password,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: "Contrasenya",
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => showPassword = !showPassword),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // REPEAT PASSWORD
              TextField(
                controller: repeat,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_reset),
                  labelText: "Repeteix la contrasenya",
                ),
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: acceptTerms,
                    onChanged: (value) {
                      setState(() => acceptTerms = value!);
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/terms");
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Accepto els ",
                          children: [
                            TextSpan(
                              text: "Termes i Condicions",
                              style: const TextStyle(
                                color: Color(0xFF4e73df),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              AppButton(
                text: "Registrar",
                icon: Icons.person_add_alt,
                loading: loading,
                onPressed: register,
              ),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Ja tens compte? Inicia sessió"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    if (email.text.isEmpty || password.text.isEmpty || repeat.text.isEmpty) {
      return _error("Omple tots els camps");
    }

    if (password.text != repeat.text) {
      return _error("Les contrasenyes no coincideixen");
    }

    if (password.text.length < 6) {
      return _error("La contrasenya ha de tenir almenys 6 caràcters");
    }
    if (!acceptTerms) {
      return _error("Has d'acceptar els termes i condicions");
    }

    setState(() => loading = true);

    final res = await AuthService.register(
      email.text.trim(),
      password.text.trim(),
      name.text.trim(),
    );

    setState(() => loading = false);

    if (res == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    } else {
      _error(res.toString());
    }
  }

  void _error(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
