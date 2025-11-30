import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';
import '../widgets/app_input_field.dart';
import '../widgets/app_button.dart';

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
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_reset,
                  size: 90, color: Color(0xFF4e73df)),
              const SizedBox(height: 20),

              const Text(
                "Restablir Contrasenya",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 10),
              const Text(
                "Introdueix el teu correu i t'enviarem\n"
                "un enllaç per restablir la contrasenya.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              AppInputField(
                controller: email,
                label: "Correu electrònic",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 20),

              AppButton(
                text: "Enviar Enllaç",
                icon: Icons.send,
                loading: loading,
                onPressed: sendReset,
              ),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Tornar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendReset() async {
    if (email.text.isEmpty) {
      return _error("Introdueix un correu vàlid");
    }

    setState(() => loading = true);

    final res = await AuthService.resetPassword(email.text.trim());

    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(res.toString())),
    );

    if (res.toString().contains("Correu enviat")) {
      Navigator.pop(context);
    }
  }

  void _error(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}
