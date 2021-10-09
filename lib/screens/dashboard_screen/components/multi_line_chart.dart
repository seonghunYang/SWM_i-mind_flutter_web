import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class MultiLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ChartIndicator(
              color: Color(0xff4af699),
              text: "민감도",
              isSquare: false,
              size: 12,
            ),
            ChartIndicator(
              color: Color(0xffaa4cfc),
              text: "지속성/몰입도",
              isSquare: false,
              size: 12,
            ),
            ChartIndicator(
              color: Color(0xff27b6fc),
              text: "주도성",
              isSquare: false,
              size: 12,
            ),
          ],
        ),
        SizedBox(
          height: defaultPadding * 2,
        ),
        Expanded(
          child: LineChart(
            sampleData1,
            swapAnimationDuration: const Duration(milliseconds: 250),
          ),
        ),
      ],
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 1,
        maxX: 4,
        maxY: 10,
        minY: 1,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: false,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.black,
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: bottomTitles,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        leftTitles: leftTitles(
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '2';
              case 4:
                return '4';
              case 6:
                return '6';
              case 8:
                return '8';
              case 10:
                return '10';
            }
            return '';
          },
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  SideTitles leftTitles({required GetTitleFunction getTitles}) => SideTitles(
        getTitles: getTitles,
        showTitles: true,
        margin: 8,
        interval: 1,
        reservedSize: 40,
        getTextStyles: (context, value) => const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 22,
        margin: 10,
        interval: 1,
        getTextStyles: (context, value) => const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '2021-03-18';
            case 2:
              return '2021-05-21';
            case 3:
              return '2021-07-31';
            case 4:
              return '2021-09-28';
          }
          return '';
        },
      );

  FlGridData get gridData => FlGridData(
        drawHorizontalLine: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.black38,
            strokeWidth: 0.25,
          );
        },
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 2),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: false,
        colors: [const Color(0xff4af699)],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          FlSpot(1, 7),
          FlSpot(2, 5),
          FlSpot(3, 4),
          FlSpot(4, 10),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: false,
        colors: [const Color(0xffaa4cfc)],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false, colors: [
          const Color(0x00aa4cfc),
        ]),
        spots: [
          FlSpot(1, 6),
          FlSpot(2, 4),
          FlSpot(3, 6),
          FlSpot(4, 8),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: false,
        colors: const [Color(0xff27b6fc)],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          FlSpot(1, 3),
          FlSpot(2, 8),
          FlSpot(3, 9),
          FlSpot(4, 8),
        ],
      );
}
