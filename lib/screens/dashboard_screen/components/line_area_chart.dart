import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../constants.dart';

class LineAreaChart extends StatelessWidget {
  const LineAreaChart({
    Key? key,
    this.bottomLineVisible = true,
    this.leftLineVisible = true,
    this.gridLineVisible = true,
    this.areaColor = kSelectedDashboardTextColor,
  }) : super(key: key);

  final bool bottomLineVisible;
  final bool leftLineVisible;
  final bool gridLineVisible;
  final Color areaColor;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.black,
          ),
        ),
        gridData: FlGridData(
          show: gridLineVisible,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.black38,
              strokeWidth: 0.25,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: bottomLineVisible,
            reservedSize: 22,
            interval: 1,
            getTextStyles: (context, value) => const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w500,
                fontSize: 12),
            getTitles: (value) {
              switch (value.toInt()) {
                case 2:
                  return 'JAN';
                case 6:
                  return 'MAR';
                case 10:
                  return 'JUN';
                case 14:
                  return 'SEP';
                case 18:
                  return 'NOV';
              }
              return '';
            },
            margin: 0,
          ),
          leftTitles: SideTitles(
            showTitles: leftLineVisible,
            interval: 1,
            getTextStyles: (context, value) => const TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return '20';
                case 2:
                  return '40';
                case 3:
                  return '60';
                case 4:
                  return '80';
                case 5:
                  return '100';
              }
              return '';
            },
            reservedSize: 22,
            margin: 12,
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        minX: 0,
        maxX: 20,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 2),
              FlSpot(1, 1.8),
              FlSpot(2, 2),
              FlSpot(3, 2.1),
              FlSpot(4, 2.2),
              FlSpot(5, 3.5),
              FlSpot(6, 4.4),
              FlSpot(7, 4.6),
              FlSpot(8, 3.9),
              FlSpot(9, 3.8),
              FlSpot(10, 4.4),
              FlSpot(11, 3.5),
              FlSpot(12, 2.9),
              FlSpot(13, 3.25),
              FlSpot(14, 3.8),
              FlSpot(15, 3.9),
              FlSpot(16, 4.1),
              FlSpot(17, 4.2),
              FlSpot(18, 4.5),
              FlSpot(19, 3.9),
              FlSpot(20, 3.8),
            ],
            isCurved: true,
            colors: [areaColor],
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              gradientFrom: Offset(1, 0),
              gradientTo: Offset(1, 0.8),
              show: true,
              colors: [
                areaColor,
                Colors.white,
              ].map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ],
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear,
    );
  }
}
