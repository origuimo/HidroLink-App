import 'package:flutter/material.dart';

class DeviceSummaryCard extends StatelessWidget {
  final int active;
  final int total;

  const DeviceSummaryCard({
    super.key,
    required this.active,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(Icons.sensors, size: 40,
              color: active == total ? Colors.green : Colors.orange),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Dispositius",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                Text("$active / $total",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
