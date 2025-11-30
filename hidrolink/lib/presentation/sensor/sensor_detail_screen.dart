import 'package:flutter/material.dart';
import 'package:hidrolink/presentation/widgets/custom_app_bar.dart';

class SensorDetailScreen extends StatefulWidget {
  final int sensorId;

  const SensorDetailScreen({super.key, required this.sensorId});

  @override
  State<SensorDetailScreen> createState() => _SensorDetailScreenState();
}

class _SensorDetailScreenState extends State<SensorDetailScreen> {
  late int selectedSensor;

  final sensors = [
    {"id": 1, "name": "Pou 1"},
    {"id": 2, "name": "Pou 2"},
  ];

  @override
  void initState() {
    super.initState();
    selectedSensor = widget.sensorId != 0 ? widget.sensorId : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: Column(
        children: [
          // Selector de sensors
          SizedBox(
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: sensors.map((s) {
                final isSelected = (s["id"] as int) == selectedSensor;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChoiceChip(
                    label: Text(s["name"] as String),
                    selected: isSelected,
                    selectedColor: const Color(0xFF4e73df),
                    onSelected: (_) {
                      setState(() {
                        selectedSensor = s["id"] as int;
                      });
                    },
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),

          // Cos de la pantalla
          Expanded(
            child: Center(
              child: Text(
                "Detalls del sensor: $selectedSensor",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
