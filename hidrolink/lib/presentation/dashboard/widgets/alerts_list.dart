import 'package:flutter/material.dart';

class AlertsList extends StatelessWidget {
  final List alerts;

  const AlertsList({
    super.key,
    required this.alerts,
  });

  IconData getIcon(String status) {
    switch (status) {
      case "pending": return Icons.error;
      case "resolved": return Icons.check_circle;
      default: return Icons.info;
    }
  }

  Color getColor(String status) {
    switch (status) {
      case "pending": return Colors.red;
      case "resolved": return Colors.green;
      default: return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: alerts.map((alert) {
        return Card(
          child: ListTile(
            leading: Icon(
              getIcon(alert["status"]),
              color: getColor(alert["status"]),
            ),
            title: Text(alert["description"]),
            subtitle: Text("${alert["sensor"]} — ${alert["date"]}"),
            trailing: Text(
              alert["status"].toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getColor(alert["status"]),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
