import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

// Color(0xff27b6fc)
class MultiLineChart extends StatelessWidget {
  final List<List<int>> lineChartBarDataSpotList;
  final List<Color> lineChartBarColorList;
  final String Function(double) getBottomTitle;

  MultiLineChart({
    required this.lineChartBarDataSpotList,
    required this.lineChartBarColorList,
    required this.getBottomTitle,
  });

  LineChartBarData getLineChartBarData(
      {required Color color, required List<int> spotDataList}) {
    return LineChartBarData(
      isCurved: false,
      colors: [color],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: getFlSpot(spotDataList),
    );
  }

  List<FlSpot> getFlSpot(List<int> spotDataList) {
    List<FlSpot> spotList = [];
    for (int idx = 0; idx < spotDataList.length; idx++) {
      spotList.add(FlSpot(idx.toDouble(), spotDataList[idx].toDouble()));
    }
    return spotList;
  }

  List<LineChartBarData> get lineBarsData => [
        getLineChartBarData(
            color: lineChartBarColorList[0],
            spotDataList: lineChartBarDataSpotList[0]),
        getLineChartBarData(
            color: lineChartBarColorList[1],
            spotDataList: lineChartBarDataSpotList[1]),
        getLineChartBarData(
            color: lineChartBarColorList[2],
            spotDataList: lineChartBarDataSpotList[2]),
        getLineChartBarData(
            color: lineChartBarColorList[3],
            spotDataList: lineChartBarDataSpotList[3]),
        getLineChartBarData(
            color: lineChartBarColorList[4],
            spotDataList: lineChartBarDataSpotList[4]),
      ];

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
            ChartIndicator(
              color: Colors.yellow,
              text: "반복하기",
              isSquare: false,
              size: 12,
            ),
            ChartIndicator(
              color: Colors.deepOrangeAccent,
              text: "밀착도",
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
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: lineChartBarDataSpotList[0].length.toDouble() - 1,
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
        getTitles: getBottomTitle,
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
}
