import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final TextInputType keyboardType;
  final IconData? icon;

  const AppInputField({
    super.key,
    required this.controller,
    required this.label,
    this.obscure = false,
    this.keyboardType = TextInputType.emailAddress,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        labelText: label,
      ),
    );
  }
}
