import 'package:ai_counseling_platform/model/linechart_metadata.dart';
import 'package:ai_counseling_platform/model/linechart_rawdata.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../constants.dart';

class LineAreaChart extends StatelessWidget {
  const LineAreaChart({
    Key? key,
    required this.lineChartRawDataSets,
    required this.lineChartMetaData,
    required this.onTap,
    this.bottomLineVisible = true,
    this.leftLineVisible = true,
    this.gridLineVisible = true,
  }) : super(key: key);

  final bool bottomLineVisible;
  final bool leftLineVisible;
  final bool gridLineVisible;
  final List<LineChartRawDataSet> lineChartRawDataSets;
  final LineChartMetaData lineChartMetaData;
  final void Function(int) onTap;

  List<LineChartBarData> getLineChartBarDatas() {
    return lineChartRawDataSets
        .map((item) => LineChartBarData(
              spots: item.values.map((e) => FlSpot(e[0], e[1])).toList(),
              isCurved: true,
              colors: [item.color],
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
                  item.color,
                  Colors.white,
                ].map((color) => color.withOpacity(0.3)).toList(),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
            if (event is FlTapUpEvent) {
              onTap(response!.lineBarSpots![0].x.toInt());
            }
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.black,
            getTooltipItems: (lineBarSpotList) {
              List<LineTooltipItem> lineTooltipList = [];
              for (int i = 0; i < lineBarSpotList.length; i++) {
                lineTooltipList.add(LineTooltipItem(
                    lineBarSpotList[i].y.toStringAsFixed(2),
                    Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: colorList[lineBarSpotList[i].barIndex])));
              }
              return lineTooltipList;
            },
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
            getTitles: lineChartMetaData.bottomTitle,
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
            getTitles: lineChartMetaData.leftTitle,
            reservedSize: 22,
            margin: 12,
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        minX: lineChartMetaData.minX,
        maxX: lineChartMetaData.maxX,
        minY: lineChartMetaData.minY,
        maxY: lineChartMetaData.maxY,
        lineBarsData: getLineChartBarDatas(),
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear,
    );
  }
}
