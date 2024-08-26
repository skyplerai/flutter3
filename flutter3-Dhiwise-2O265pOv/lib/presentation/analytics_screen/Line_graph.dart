import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EntriesLineChart extends StatelessWidget {
  final List<int> entriesPerDay;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;

  EntriesLineChart({
    required this.entriesPerDay,
    this.width = 300,
    this.height = 200,
    this.margin = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(15),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      days[value.toInt()],
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  );
                },
                interval: 1,
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Remove y-axis labels
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(entriesPerDay.length, (index) {
                return FlSpot(index.toDouble(), entriesPerDay[index].toDouble());
              }),
              isCurved: true,
              color: Colors.orange,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    color: Colors.orange,
                    radius: 6,
                    strokeWidth: 3,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.withOpacity(0.3),
                    Colors.purple.withOpacity(0.3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ), // Gradient for the shaded area
              ),
            ),
          ],
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: entriesPerDay.reduce((a, b) => a > b ? a : b).toDouble(),
        ),
      ),
    );
  }
}
