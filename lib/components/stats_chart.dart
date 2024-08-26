import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // FLChart kütüphanesini eklemeyi unutmayın

class StatsChart extends StatelessWidget {
  final List<BarChartGroupData>? barGroups;
  final List<LineChartBarData>? lineBars;
  final List<ScatterSpot>? scatterSpots;
  final List<RadarDataSet>? radarData; // RadarDataSet tipi düzeltildi
  final List<PieChartSectionData>? pieSections;
  final String title;
  final String chartType; // 'bar', 'line', 'scatter', 'radar', 'pie'

  const StatsChart({
    super.key,
    this.barGroups,
    this.lineBars,
    this.scatterSpots,
    this.radarData,
    this.pieSections,
    this.title = '',
    this.chartType = 'bar', // Varsayılan olarak 'bar' chart
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: _buildChart(),
        ),
      ],
    );
  }

  Widget _buildChart() {
    switch (chartType) {
      case 'bar':
        return BarChart(
          BarChartData(
            
            alignment: BarChartAlignment.spaceAround,
            barGroups: barGroups ?? [], // Boş liste varsayılanı
            titlesData: const FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
          ),
        );
      case 'line':
        return LineChart(
          LineChartData(
            lineBarsData: lineBars ?? [], // Boş liste varsayılanı
            titlesData: const FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
          ),
        );
      case 'scatter':
        return ScatterChart(
          ScatterChartData(
            scatterSpots: scatterSpots ?? [], // Boş liste varsayılanı
            titlesData: const FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
          ),
        );
      case 'radar':
        return RadarChart(
          RadarChartData(
            dataSets: radarData ?? [], // Boş liste varsayılanı
            radarBackgroundColor: Colors.transparent,
            borderData: FlBorderData(show: false),
          ),
        );
      case 'pie':
        return PieChart(
          PieChartData(
            sections: pieSections ?? [], // Boş liste varsayılanı
            borderData: FlBorderData(show: false),
          ),
        );
      default:
        return const Center(
          child: Text(
            'Unsupported chart type',
            style: TextStyle(color: Colors.white),
          ),
        );
    }
  }
}
