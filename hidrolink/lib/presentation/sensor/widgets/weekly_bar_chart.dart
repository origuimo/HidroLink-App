import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<double> values;
  final double height;

  const WeeklyBarChart({
    super.key,
    required this.values,
    this.height = 200,
  });

  // Decideix quantes línies volem verticals
  int _desiredLineCount(double chartHeight) {
    return (chartHeight / 28).floor().clamp(3, 8);
  }

  // Step intel·ligent (0.5, 1, 2, 5...)
  double _smartStep(double maxValue, int divisions) {
    final raw = maxValue / divisions;

    if (raw <= 0.5) return 0.5;
    if (raw <= 1) return 1;
    if (raw <= 2) return 2;
    if (raw <= 5) return 5;
    return (raw).ceilToDouble();
  }

  @override
  Widget build(BuildContext context) {
    final double maxValue =
        values.isEmpty ? 1 : values.reduce((a, b) => a > b ? a : b);

    final int divisions = _desiredLineCount(height);
    final double step = _smartStep(maxValue, divisions);

    // MAX Y JUST I PRECÍS
    final double maxY = (maxValue / step).ceil() * step;

    return SizedBox(
      height: height,
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: maxY,

          titlesData: FlTitlesData(
            show: true,

            // --- LEFT Y ---
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: step,
                reservedSize: 34,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      value.toStringAsFixed(
                          value % 1 == 0 ? 0 : 1), // 1 → "1", 1.5 → "1.5"
                      style:
                          const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),

            // Apaguem top i right
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),

            // --- BOTTOM X ---
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  const labels = ['Dl', 'Dm', 'Dc', 'Dj', 'Dv', 'Ds', 'Dg'];

                  int i = value.toInt();
                  if (i < 0 || i >= labels.length) {
                    return const SizedBox.shrink();
                  }

                  return SideTitleWidget(
                    meta: meta,
                    space: 6,
                    child: Text(
                      labels[i],
                      style:
                          const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),

          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            horizontalInterval: step,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.withOpacity(0.15),
              strokeWidth: 1,
            ),
            drawVerticalLine: false,
          ),

          borderData: FlBorderData(show: false),

          barGroups: values.asMap().entries.map((entry) {
            final index = entry.key;
            final value = entry.value;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value,
                  width: 18,
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFF4e73df),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
