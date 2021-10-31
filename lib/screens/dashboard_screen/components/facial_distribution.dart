import 'package:ai_counseling_platform/model/linechart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/pie_odd_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'facial_info_card.dart';

class FacialDistribution extends StatelessWidget {
  const FacialDistribution({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "최근 감정 분포",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        PieOddChart(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ChartIndicator(
                color: kSelectedContainerColor, text: "침착", isSquare: true),
            ChartIndicator(color: kMainColor, text: "행복", isSquare: true),
          ],
        ),
        SizedBox(
          height: defaultPadding * 1.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ChartIndicator(color: Colors.yellow, text: "슬픔", isSquare: true),
            ChartIndicator(color: Colors.red, text: "분노", isSquare: true),
          ],
        ),
        SizedBox(
          height: defaultPadding,
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Expanded(
          flex: 5,
          child: FacialInfoCard(
            title: '행복',
            amount: "340",
            svgSrc: "assets/icons/smile.svg",
            percent: 28,
            color: kMainColor,
            dataset:
                LineChartRawDataSet(title: "--", color: kMainColor, values: [
              [0, 2],
              [1, 1.8],
              [2, 2],
              [3, 2.1],
              [4, 2.2],
              [5, 3.5],
              [6, 4.4],
              [7, 4.6],
              [8, 3.9],
              [9, 3.8],
              [10, 4.4],
              [11, 3.5],
              [12, 2.9],
              [13, 3.25],
              [14, 3.8],
              [15, 3.9],
              [16, 4.1],
              [17, 4.2],
              [18, 4.5],
              [19, 3.9],
              [20, 3.8],
            ]),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 5,
          child: FacialInfoCard(
            title: '슬픔',
            amount: "340",
            svgSrc: "assets/icons/smile.svg",
            percent: 26.3,
            color: Colors.yellow,
            dataset:
                LineChartRawDataSet(title: "--", color: Colors.yellow, values: [
              [0, 1],
              [1, 1.1],
              [2, 1.2],
              [3, 0.9],
              [4, 1.1],
              [5, 1.3],
              [6, 2.1],
              [7, 1.2],
              [8, 1.1],
              [9, 0.8],
              [10, 0.7],
              [11, 0.6],
              [12, 0.8],
              [13, 0.8],
              [14, 0.4],
              [15, 0.6],
              [16, 0.7],
              [17, 0.9],
              [18, 1.1],
              [19, 1.3],
              [20, 1.1],
            ]),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 5,
          child: FacialInfoCard(
            title: '화남',
            amount: "340",
            svgSrc: "assets/icons/smile.svg",
            percent: 26.3,
            color: Colors.red,
            dataset:
                LineChartRawDataSet(title: "--", color: Colors.red, values: [
              [0, 1.0],
              [1, 1.3],
              [2, 1.1],
              [3, 0.6],
              [4, 1.3],
              [5, 1.4],
              [6, 1.2],
              [7, 1.3],
              [8, 1.5],
              [9, 0.6],
              [10, 0.8],
              [11, 0.7],
              [12, 0.8],
              [13, 0.6],
              [14, 0.5],
              [15, 0.5],
              [16, 0.6],
              [17, 0.7],
              [18, 1.0],
              [19, 1.1],
              [20, 1.0],
            ]),
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
