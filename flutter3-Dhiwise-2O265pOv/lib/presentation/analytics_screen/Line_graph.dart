import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class VisitCountLineChart extends StatelessWidget {
  final List<int> visitCounts;
  final List<String> dates;

  VisitCountLineChart({required this.visitCounts, required this.dates});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 30),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index >= 0 && index < dates.length) {
                  return Text(dates[index], style: TextStyle(fontSize: 10));
                }
                return const Text('');
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        minX: 0,
        maxX: (visitCounts.length - 1).toDouble(),
        minY: 0,
        maxY: visitCounts.reduce((a, b) => a > b ? a : b).toDouble(),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              visitCounts.length,
                  (index) => FlSpot(index.toDouble(), visitCounts[index].toDouble()),
            ),
            isCurved: true,
            color: Colors.lightBlueAccent,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('House Visit Count')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: VisitCountLineChart(
          visitCounts: [2, 4, 1, 5, 3, 7, 6],  // Sample data
          dates: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],  // Sample dates
        ),
      ),
    ),
  ));
}
