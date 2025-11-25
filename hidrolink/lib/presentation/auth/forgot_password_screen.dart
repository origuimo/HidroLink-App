import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final email = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(Icons.lock_reset, size: 80, color: Color(0xFF4e73df)),
              const SizedBox(height: 20),
              const Text(
                "Restablir Contrasenya",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Introdueix el teu correu i rebràs un enllaç\nper restablir la contrasenya.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              TextField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: "Correu electrònic",
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Color(0xFF4e73df),
                ),
                onPressed: loading ? null : sendResetEmail,
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Enviar Enllaç"),
              ),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Tornar"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendResetEmail() async {
    setState(() => loading = true);
    final res = await AuthService.resetPassword(email.text);
    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(res.toString())),
    );
  }
}
