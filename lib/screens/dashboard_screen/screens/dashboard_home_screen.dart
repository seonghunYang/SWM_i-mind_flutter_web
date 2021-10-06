import 'package:ai_counseling_platform/screens/dashboard_screen/components/number_data_card.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../constants.dart';

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: defaultPadding * 2.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: defaultPadding * 5,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Dashboard",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: NumberDataCard(
                              title: "상담한 고객수",
                              number: "302",
                              icon: Icon(
                                Icons.people_outline,
                                color: Colors.white,
                                size: 26,
                              ),
                              colors: [
                                Color(0xff3ABE76),
                                Color(0xff53E193),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: defaultPadding * 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: NumberDataCard(
                              title: "이번달 예약수",
                              number: "26",
                              icon: Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.white,
                                size: 26,
                              ),
                              colors: [
                                Color(0xffE8B83D),
                                Color(0xffFCD163),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: defaultPadding * 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: NumberDataCard(
                              title: "오늘 예약수",
                              number: "3",
                              icon: Icon(
                                Icons.pending_actions,
                                color: Colors.white,
                                size: 26,
                              ),
                              colors: [
                                Color(0xff667AC9),
                                Color(0xffA1B0EA),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: defaultPadding * 2,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Card(
                              elevation: 8,
                              shadowColor: Colors.black38,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(defaultPadding * 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "신규 고객 추이",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    AspectRatio(
                                      aspectRatio: 1.4,
                                      child: LineAreaChart(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: defaultPadding * 2,
                          ),
                          Expanded(
                            flex: 3,
                            child: Card(
                              elevation: 8,
                              shadowColor: Colors.black38,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(defaultPadding * 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "신규 고객 추이",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    AspectRatio(
                                      aspectRatio: 1.4,
                                      child: DashboardBarChart(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.red,
                  height: 500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardBarChart extends StatelessWidget {
  const DashboardBarChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.blueGrey,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String weekDay;
                switch (group.x.toInt()) {
                  case 0:
                    weekDay = 'Monday';
                    break;
                  case 1:
                    weekDay = 'Tuesday';
                    break;
                  case 2:
                    weekDay = 'Wednesday';
                    break;
                  case 3:
                    weekDay = 'Thursday';
                    break;
                  case 4:
                    weekDay = 'Friday';
                    break;
                  case 5:
                    weekDay = 'Saturday';
                    break;
                  case 6:
                    weekDay = 'Sunday';
                    break;
                  default:
                    throw Error();
                }
                return BarTooltipItem(
                  weekDay + '\n',
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: (rod.y - 1).toString(),
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }
}

class LineAreaChart extends StatelessWidget {
  const LineAreaChart({
    Key? key,
  }) : super(key: key);

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
          show: true,
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
            showTitles: true,
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
            showTitles: true,
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
            colors: [Color(0xff5CB082)],
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
                Color(0xffa2e2a9),
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
