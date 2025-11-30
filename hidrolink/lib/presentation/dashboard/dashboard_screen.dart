import 'package:flutter/material.dart';
import 'widgets/device_summary_card.dart';
import 'widgets/alert_summary_card.dart';
import 'widgets/sensor_card.dart';
import 'widgets/alerts_list.dart';
import '../widgets/custom_app_bar.dart';

class DashboardScreen extends StatelessWidget {
  final Function(int) onSensorTap;

  DashboardScreen({super.key, required this.onSensorTap});
  final mockDevices = [
    {
      "id": 1,
      "name": "Sensor Pou 1",
      "pressure": 3.2,
      "lastUpdate": "Fa 5 min",
      "status": "online",
      "power": "main",
      "todayValues": [2.8, 2.9, 3.1, 3.3, 3.2, 3.0],
    },
    {
      "id": 2,
      "name": "Sensor Pou 2",
      "pressure": 0.0,
      "lastUpdate": "Fa 2 h",
      "status": "offline",
      "power": "battery",
      "todayValues": [0, 0, 0, 0, 0],
    },
  ];

  final mockAlerts = [
    {
      "date": "2025-01-13 14:22",
      "sensor": "Pou 1",
      "description": "Pressió baixa detectada",
      "status": "pending",
    },
    {
      "date": "2025-01-13 09:10",
      "sensor": "Pou 2",
      "description": "Ha tornat la llum",
      "status": "info",
    },
    {
      "date": "2025-01-12 19:40",
      "sensor": "Pou 1",
      "description": "Fuita reparada",
      "status": "resolved",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final activeDevices = mockDevices
        .where((d) => d["status"] == "online")
        .length;
    final pendingAlerts = mockAlerts
        .where((a) => a["status"] == "pending")
        .length;

    return Scaffold(
      appBar: const AppTopBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --------- Row amb les dues targetes superiors -------------
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // Navega a la llista de dispositius (ruta /devices si existeix)
                      Navigator.pushNamed(context, "/devices");
                    },
                    child: DeviceSummaryCard(
                      active: activeDevices,
                      total: mockDevices.length,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // Navega a la pantalla d'alertes (ruta /alerts si existeix)
                      Navigator.pushNamed(context, "/alerts");
                    },
                    child: AlertSummaryCard(count: pendingAlerts),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // SENSORS (cada targeta per sensor)
            Column(
              children: mockDevices.map((s) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () => onSensorTap(s["id"] as int),
                    child: SensorCard(sensor: s),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Alertes recents",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 10),

            AlertsList(alerts: mockAlerts),
          ],
        ),
      ),
    );
  }
}
