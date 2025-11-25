import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double currentPressure = 2.4; // placeholder temporal
  String lastUpdate = "Fa 10 segons";
  bool online = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estat del Reg"),
        backgroundColor: const Color(0xFF4e73df),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildDeviceHeader(),

            const SizedBox(height: 20),

            _buildPressureCard(),

            const SizedBox(height: 20),

            _buildMiniChart(),

            const SizedBox(height: 30),

            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  // -------------------------
  // Widget 1: Header dispositiu
  // -------------------------
  Widget _buildDeviceHeader() {
    return Row(
      children: [
        Icon(
          online ? Icons.check_circle : Icons.cancel,
          size: 28,
          color: online ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 12),
        Text(
          online ? "Dispositiu online" : "Dispositiu offline",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  // -------------------------
  // Widget 2: Targeta pressió
  // -------------------------
  Widget _buildPressureCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pressió Actual",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Text(
                  "$currentPressure bar",
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4e73df),
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.water_drop,
                  size: 36,
                  color: Colors.blue[300],
                )
              ],
            ),

            const SizedBox(height: 10),
            Text(
              "Última actualització: $lastUpdate",
              style: TextStyle(color: Colors.grey[600]),
            )
          ],
        ),
      ),
    );
  }

  // -------------------------
  // Widget 3: Mini gràfica fake
  // -------------------------
  Widget _buildMiniChart() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(blurRadius: 4, color: Colors.black12),
        ],
      ),
      child: const Center(
        child: Text(
          "Mini gràfica (placeholder)\nDesprés hi posem la real",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // -------------------------
  // Widget 4: Botons
  // -------------------------
  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4e73df),
            minimumSize: const Size.fromHeight(50),
          ),
          icon: const Icon(Icons.show_chart),
          label: const Text("Veure anàlisi"),
          onPressed: () {
            Navigator.pushNamed(context, "/analysis");
          },
        ),

        const SizedBox(height: 12),

        OutlinedButton.icon(
          icon: const Icon(Icons.settings),
          label: const Text("Configuració del dispositiu"),
          onPressed: () {
            Navigator.pushNamed(context, "/devices");
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
          ),
        ),
      ],
    );
  }
}
