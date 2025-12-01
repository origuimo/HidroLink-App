import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DayDetailSheet extends StatefulWidget {
  final Map dayData; // mock: { date: '2025-01-13', totalHours: 3.2, minP: 1.8, maxP: 3.4, sessions: [...] }
  const DayDetailSheet({super.key, required this.dayData});

  @override
  State<DayDetailSheet> createState() => _DayDetailSheetState();
}

class _DayDetailSheetState extends State<DayDetailSheet> {
  // shows 'day' or 'session'
  bool showingSession = false;
  Map? selectedSession;

  @override
  Widget build(BuildContext context) {
    final sessions = (widget.dayData['sessions'] as List).cast<Map>();
    final daySpots = (widget.dayData['daySpots'] as List).map((e) => FlSpot((e['x'] as num).toDouble(), (e['y'] as num).toDouble())).toList();

    List<FlSpot> currentSpots = showingSession && selectedSession != null
        ? (selectedSession!['spots'] as List).map((e) => FlSpot((e['x'] as num).toDouble(), (e['y'] as num).toDouble())).toList()
        : daySpots;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.92,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                if (showingSession)
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        showingSession = false;
                        selectedSession = null;
                      });
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Tornar al dia'),
                  ),
              ],
            ),

            const SizedBox(height: 8),
            Text(
              "Detalls del dia: ${widget.dayData['date']}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            // big line chart for the day or session
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: 24,
                      minY: currentSpots.isEmpty ? 0 : currentSpots.map((s) => s.y).reduce((a, b) => a < b ? a : b) - 0.5,
                      maxY: currentSpots.isEmpty ? 1 : currentSpots.map((s) => s.y).reduce((a, b) => a > b ? a : b) + 0.5,
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 6, getTitlesWidget: (v, meta) {
                          return Text("${v.toInt()}:00");
                        })),
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(show: true, drawVerticalLine: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: currentSpots,
                          isCurved: true,
                          color: const Color(0xFF4e73df),
                          barWidth: 3,
                          dotData: const FlDotData(show: false),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text("Sessions del dia", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),

            // sessions list
            Expanded(
              child: ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context, idx) {
                  final s = sessions[idx];
                  return Card(
                    child: ListTile(
                      title: Text("Sessió ${idx + 1} — ${s['start']} - ${s['end']}"),
                      subtitle: Text("Duració: ${s['duration']} • Min ${s['minP']} • Max ${s['maxP']}"),
                      trailing: TextButton(
                        onPressed: () {
                          setState(() {
                            showingSession = true;
                            selectedSession = s;
                          });
                        },
                        child: const Text("Veure"),
                      ),
                      onTap: () {
                        setState(() {
                          showingSession = true;
                          selectedSession = s;
                        });
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
