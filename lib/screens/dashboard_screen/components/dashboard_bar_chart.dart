import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/animation.dart';

class DashboardBarChart extends StatefulWidget {
  const DashboardBarChart({
    Key? key,
    required this.maxY,
    required this.getTooltipItem,
    required this.getBottomTitle,
    required this.getLeftTitle,
    required this.barDataList,
    required this.gridData,
  }) : super(key: key);

  final double maxY;
  final BarTooltipItem Function(BarChartGroupData, int, BarChartRodData, int)
      getTooltipItem;
  final String Function(double) getBottomTitle;
  final String Function(double) getLeftTitle;
  final List<List<double>> barDataList;
  final FlGridData? gridData;

  @override
  State<DashboardBarChart> createState() => _DashboardBarChartState();
}

class _DashboardBarChartState extends State<DashboardBarChart> {
  int touchedIndex = -1;

  BarChartGroupData makeGroupData(int x, double y, {required isTouched}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: [
            isTouched ? const Color(0xff3fc37c) : const Color(0xffd1f8e4)
          ],
          width: 22,
          borderSide: isTouched
              ? BorderSide(color: Color(0xff3FC37C), width: 1)
              : BorderSide(color: Color(0xffD1F8E4), width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [Colors.white],
          ),
        ),
      ],
      showingTooltipIndicators: [],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(
      widget.barDataList.length,
      (i) => makeGroupData(
          widget.barDataList[i][0].toInt(), widget.barDataList[i][1],
          isTouched: i == touchedIndex));

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: widget.maxY,
        barTouchData: BarTouchData(
          touchCallback: (FlTouchEvent event, barTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  barTouchResponse == null ||
                  barTouchResponse.spot == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            });
          },
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.black,
            getTooltipItem: widget.getTooltipItem,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontSize: 14),
            margin: 16,
            getTitles: widget.getBottomTitle,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTextStyles: (context, value) => const TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            getTitles: widget.getLeftTitle,
            reservedSize: 22,
            margin: 12,
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: showingGroups(),
        gridData: widget.gridData,
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }
}
