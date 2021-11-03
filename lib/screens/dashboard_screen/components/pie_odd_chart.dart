import 'package:ai_counseling_platform/controllers/counseling_record_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../../constants.dart';

class PieOddChart extends StatefulWidget {
  const PieOddChart({
    Key? key,
  }) : super(key: key);

  @override
  State<PieOddChart> createState() => _PieOddChartState();
}

class _PieOddChartState extends State<PieOddChart> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    CounselingRecordController counselingRecordController =
        context.watch<CounselingRecordController>();
    int currentIndex = counselingRecordController.currentIndex;
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              startDegreeOffset: -90,
              centerSpaceRadius: 60,
              sections: showingSections(currentIndex: currentIndex),
              pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              }),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  '긍정 감정',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  '37.1%',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections({required int currentIndex}) {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 12.0 : 10.0;
      final radius = isTouched ? 40.0 : 30.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: kSelectedContainerColor,
            value: currentIndex == 0 ? 18 : 32,
            title: currentIndex == 0 ? "18%" : '32%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: kMainColor,
            value: currentIndex == 0 ? 69 : 48,
            title: currentIndex == 0 ? "69%" : '48%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.yellow,
            value: currentIndex == 0 ? 6 : 8,
            title: currentIndex == 0 ? "6%" : '8%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.red,
            value: currentIndex == 0 ? 5 : 8,
            title: currentIndex == 0 ? "5%" : '8%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
            color: kDasboardTextColor,
            value: currentIndex == 0 ? 2 : 4,
            title: currentIndex == 0 ? "2%" : '4%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
