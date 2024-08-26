import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:switchedon/components/stats_chart.dart';

class PerformancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Performance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: <Widget>[
          StatsChart(
            barGroups: _generateBarGroups(),
            lineBars: _generateLineBars(),
            title: 'Performance Overview',
            chartType: 'bar', // 'bar' chart olarak ayarlanmış
          ),
          const SizedBox(height: 20),
          StatsChart(
            barGroups: _generateBarGroups(),
            lineBars: _generateLineBars(),
            title: 'Performance Overview',
            chartType: 'line', // 'line' chart olarak ayarlanmış
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return List.generate(
      7,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (index + 1) * 10.0,
            color: Colors.blue,
            width: 15,
          ),
        ],
      ),
    );
  }

  List<LineChartBarData> _generateLineBars() {
    return [
      LineChartBarData(
        spots: List.generate(
          7,
          (index) => FlSpot(index.toDouble(), (index + 1) * 10.0),
        ),
        isCurved: true,
        color: Colors.red,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }
}
