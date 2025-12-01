import 'package:flutter/material.dart';
import 'widgets/weekly_bar_chart.dart';
import 'day_detail_sheet.dart';
import '../widgets/custom_app_bar.dart';

class SensorDetailScreen extends StatefulWidget {
  final int sensorId;
  final List<Map>? sensorsList; // opcional: llista per fer selector dinàmic

  const SensorDetailScreen({
    super.key,
    required this.sensorId,
    this.sensorsList,
  });

  @override
  State<SensorDetailScreen> createState() => _SensorDetailScreenState();
}

class _SensorDetailScreenState extends State<SensorDetailScreen> {
  late int selectedSensorId;

  // MOCKS: substitueix per dades reals després
  final List<Map<String, dynamic>> sensors = [
    {"id": 1, "name": "Pou 1"},
    {"id": 2, "name": "Pou 2"},
    {"id": 3, "name": "Dipòsit"},
  ];

  int currentWeek = 0; // 0 = aquesta setmana, -1 = la passada, -2 = fa dues...
  List<double> getWeeklyValues() {
    if (currentWeek == 0) return mockWeekly; // Actual
    if (currentWeek == -1) return [2, 1.5, 0, 3, 2.2, 0, 1.1]; // Exemple
    return List.generate(7, (_) => 0);
  }

  // mock weekly hours (7 dies)
  final mockWeekly = [1.2, 3.4, 0.0, 2.5, 4.0, 0.0, 2.1];

  // mock days list: cada dia amb sessions i spots (per la grafica del dia)
  final mockDays = [
    {
      "date": "2025-11-25",
      "totalHours": 3.5,
      "minP": 1.8,
      "maxP": 3.4,
      "daySpots": List.generate(
        25,
        (i) => {"x": i, "y": (i % 6 == 0 ? 0.0 : (1.5 + (i % 6) * 0.3))},
      ),
      "sessions": [
        {
          "start": "07:10",
          "end": "07:40",
          "duration": "30m",
          "minP": 1.9,
          "maxP": 3.0,
          "spots": List.generate(
            10,
            (i) => {"x": 7 + i * 0.3, "y": 2.0 + (i % 3) * 0.4},
          ),
        },
        {
          "start": "13:00",
          "end": "13:25",
          "duration": "25m",
          "minP": 2.1,
          "maxP": 3.3,
          "spots": List.generate(
            8,
            (i) => {"x": 13 + i * 0.3, "y": 2.3 + (i % 2) * 0.5},
          ),
        },
      ],
    },
    // més dies mock...
  ];

  @override
  void initState() {
    super.initState();
    selectedSensorId = widget.sensorId != 0
        ? widget.sensorId
        : (sensors.first['id'] as int);
  }

  void openDayDetail(Map day) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.92,
          minChildSize: 0.5,
          maxChildSize: 0.98,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: DayDetailSheet(dayData: day),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // find sensor
    final currentSensor = sensors.firstWhere(
      (s) => (s['id'] as int) == selectedSensorId,
    );
    final sensorName = currentSensor['name'] as String;

    // small summary values (mock)
    final currentPressure = 3.2;
    final hoursToday = 1.2;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          titleSpacing: 0,
          title: Row(
            children: [
              const SizedBox(width: 12),
              Image.asset("assets/images/logo.png", height: 32),
              const SizedBox(width: 10),
              const Text(
                "HIDROLINK",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: PopupMenuButton<int>(
                  onSelected: (id) => setState(() => selectedSensorId = id),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  itemBuilder: (_) => sensors.map((s) {
                    return PopupMenuItem<int>(
                      value: s["id"],
                      child: Text(s["name"]),
                    );
                  }).toList(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        Text(
                          sensors.firstWhere(
                            (s) => s["id"] == selectedSensorId,
                          )["name"],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_drop_down, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // summary small cards row
            Card(
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ──────────────── TÍTOLS + ICONS ────────────────
                    Row(
                      children: [
                        // PRESSIÓ
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // 👈 AIXÒ ÉS CLAU
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // 👈 Icon + text centrats
                                children: const [
                                  Icon(
                                    Icons.water_drop,
                                    size: 16,
                                    color: Color(0xFF4e73df),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Pressió",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "$currentPressure bar",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // HORES AVUI
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 16,
                                    color: Color(0xFF4e73df),
                                  ),
                                  SizedBox(width: 4),
                                  Text("Avui", style: TextStyle(fontSize: 13)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${hoursToday.toStringAsFixed(1)} h",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // SETMANA
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 16,
                                    color: Color(0xFF4e73df),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Setmana",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${mockWeekly.reduce((a, b) => a + b).toStringAsFixed(1)} h",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Container(height: 1, color: Colors.grey.withOpacity(0.25)),
                    const SizedBox(height: 12),

                    // ──────────────── REG SETMANAL ────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: mockWeekly.asMap().entries.map((e) {
                        final idx = e.key;
                        final val = e.value;
                        final has = val > 0;

                        return Column(
                          children: [
                            Text(
                              ["Dl", "Dm", "Dc", "Dj", "Dv", "Ds", "Dg"][idx],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: has
                                    ? const Color(0xFF4e73df)
                                    : Colors.grey.shade300,
                                shape: BoxShape.circle,
                                boxShadow: has
                                    ? [
                                        BoxShadow(
                                          color: const Color(
                                            0xFF4e73df,
                                          ).withOpacity(0.25),
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                        ),
                                      ]
                                    : [],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // weekly bar chart
            Row(
              children: const [
                Icon(Icons.bar_chart, size: 18, color: Color(0xFF4e73df)),
                SizedBox(width: 8),
                Text(
                  "Hores regades (setmana actual)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity == null) return;

                // SWIPE ESQUERRA → VELOCITAT NEGATIVA → setmanes antigues
                if (details.primaryVelocity! > 0) {
                  setState(() => currentWeek -= 1);
                }
                // SWIPE DRETA → VELOCITAT POSITIVA → setmanes més recents
                else if (details.primaryVelocity! < 0) {
                  if (currentWeek < 0) {
                    setState(() => currentWeek += 1);
                  }
                }
              },

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(Icons.swipe, size: 18, color: Colors.grey.shade600),
                      SizedBox(width: 6),
                      Text(
                        currentWeek == 0
                            ? "Setmana actual"
                            : "Fa ${currentWeek.abs()} setmana(es)",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),
                  WeeklyBarChart(values: getWeeklyValues()),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: const [
                Icon(Icons.calendar_today, size: 18, color: Color(0xFF4e73df)),
                SizedBox(width: 8),
                Text(
                  "Històric per dies",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // days list as cards
            Column(
              children: mockDays.map((d) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    child: ListTile(
                      title: Text(d['date'] as String),
                      subtitle: Text(
                        "Hores: ${(d['totalHours'] as num).toStringAsFixed(1)} • Sessions: ${(d['sessions'] as List).length}",
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () => openDayDetail(d),
                      ),
                      onTap: () => openDayDetail(d),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
