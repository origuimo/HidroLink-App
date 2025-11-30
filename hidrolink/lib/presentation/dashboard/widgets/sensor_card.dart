import 'package:flutter/material.dart';
import 'mini_line_chart.dart';

class SensorCard extends StatelessWidget {
  final Map sensor;

  const SensorCard({super.key, required this.sensor});

  Color getStatusColor(String status) {
    switch (status) {
      case "online":
        return Colors.green;
      case "offline":
        return Colors.red;
      case "alert":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 14,
                  color: getStatusColor(sensor["status"]),
                ),
                const SizedBox(width: 8),
                Text(
                  sensor["name"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  sensor["power"] == "main" ? "Principal" : "Bateria",
                  style: TextStyle(
                    color: sensor["power"] == "main"
                        ? Colors.blue
                        : Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // PRESSIÓ
            Row(
              children: [
                Text(
                  "${sensor["pressure"]} bar",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4e73df),
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.water_drop, size: 35, color: Colors.blue[300]),
              ],
            ),

            const SizedBox(height: 8),
            Text(
              "Última lectura: ${sensor["lastUpdate"]}",
              style: TextStyle(color: Colors.grey[700]),
            ),

            const SizedBox(height: 12),

            // MINI GRÀFICA MOCK
            const SizedBox(height: 12),

            MiniLineChart(
              values: (sensor["todayValues"] as List)
                  .map((v) => (v as num).toDouble())
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
