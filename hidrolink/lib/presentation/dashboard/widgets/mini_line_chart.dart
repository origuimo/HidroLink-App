import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MiniLineChart extends StatelessWidget {
  final List<double> values;

  const MiniLineChart({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: values.length.toDouble() - 1,

          minY: values.reduce((a, b) => a < b ? a : b) - 0.5,
          maxY: values.reduce((a, b) => a > b ? a : b) + 0.5,

          // ❌ No titles / no grid → línia neta
          titlesData: const FlTitlesData(show: false),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),

          // ⭐ TOOLTIP NOU (API fl_chart 0.68+)
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBorder: BorderSide(color: Colors.blue.shade300, width: 1),
              tooltipPadding: const EdgeInsets.all(8),
              tooltipBorderRadius: BorderRadius.circular(8), // ✔ funciona en la nova API
              getTooltipColor: (touchedSpot) =>
                  Colors.white.withOpacity(0.95), // ✔ substitueix tooltipBgColor
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    "Hora: ${spot.x.toInt()}:00\n"
                    "Pressió: ${spot.y.toStringAsFixed(2)} bar",
                    const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList();
              },
            ),
            handleBuiltInTouches: true,
          ),

          // ⭐ La línia
          lineBarsData: [
            LineChartBarData(
              spots: values
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: true,
              color: const Color(0xFF4e73df),
              barWidth: 3,
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
