import 'package:flutter/material.dart';

class AlertSummaryCard extends StatelessWidget {
  final int count;

  const AlertSummaryCard({
    super.key,
    required this.count,
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
            Icon(Icons.warning_amber_rounded, size: 40,
              color: count > 0 ? Colors.red : Colors.green),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Alertes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                Text("$count",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: count > 0 ? Colors.red : Colors.green,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
