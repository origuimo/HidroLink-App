import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';
import '../sensor/sensor_detail_screen.dart';
import '../porfile/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  final int initialSensorId; // per quan vens del dashboard amb un sensor

  const BottomNavScreen({super.key, this.initialSensorId = 0});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int index = 0;
  int selectedSensorId = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialSensorId != 0) {
      index = 1; // obre pestanya de sensor
      selectedSensorId = widget.initialSensorId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(
        onSensorTap: (id) {
          setState(() {
            index = 1;
            selectedSensorId = id;
          });
        },
      ),
      SensorDetailScreen(sensorId: selectedSensorId),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() => index = i);
        },
        selectedItemColor: const Color(0xFF4e73df),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors),
            label: "Sensor",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
