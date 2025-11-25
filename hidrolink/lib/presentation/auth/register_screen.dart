import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';
import '../../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final repeat = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Icon(Icons.person_add, size: 80, color: Color(0xFF4e73df)),
            const SizedBox(height: 20),
            const Text(
              "Crear Compte",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: "Correu electrònic",
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Contrasenya",
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: repeat,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Repeteix la contrasenya",
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: const Color(0xFF4e73df),
              ),
              onPressed: loading ? null : register,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Registrar"),
            ),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Ja tens compte? Inicia sessió"),
            ),
          ],
        ),
      ),
    );
  }

  void register() async {
    if (password.text != repeat.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Les contrasenyes no coincideixen")),
      );
      return;
    }

    setState(() => loading = true);
    final res = await AuthService.register(email.text, password.text);

    setState(() => loading = false);

    if (res == true) {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res.toString())),
      );
    }
  }
}
