import 'package:flutter/material.dart';
import 'package:hidrolink/presentation/widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: const Center(child: Text("Perfil de l'usuari")),
    );
  }
}
