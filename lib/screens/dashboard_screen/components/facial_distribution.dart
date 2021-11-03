import 'package:ai_counseling_platform/controllers/counseling_record_controller.dart';
import 'package:ai_counseling_platform/model/linechart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/pie_odd_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../../constants.dart';
import 'facial_info_card.dart';

const List facial = [
  {
    "happy": <List<double>>[
      [0, 9],
      [1, 9.1],
      [2, 9.2],
      [3, 9.9],
      [4, 9.1],
      [5, 9.3],
      [6, 9.1],
      [7, 8.2],
      [8, 9.1],
      [9, 8.8],
      [10, 9.7],
      [11, 9.6],
      [12, 8.8],
      [13, 7.8],
      [14, 8.4],
      [15, 7.6],
      [16, 8.7],
      [17, 8.9],
      [18, 7.1],
      [19, 8.3],
      [20, 9.1],
    ],
    "sad": <List<double>>[
      [0, 1],
      [1, 1.1],
      [2, 0.2],
      [3, 0.9],
      [4, 1.1],
      [5, 1.3],
      [6, 0.1],
      [7, 1.2],
      [8, 0.1],
      [9, 0.8],
      [10, 0.7],
      [11, 0.6],
      [12, 0.8],
      [13, 0.8],
      [14, 0.4],
      [15, 0.6],
      [16, 0.7],
      [17, 1.9],
      [18, 1.1],
      [19, 1.1],
      [20, 1.3],
    ],
    "angry": <List<double>>[
      [0, 1.0],
      [1, 0.3],
      [2, 1.1],
      [3, 0.6],
      [4, 1.3],
      [5, 0.4],
      [6, 1.2],
      [7, 0.3],
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
    ]
  },
  {
    "happy": <List<double>>[
      [21, 2],
      [20, 1.8],
      [19, 2],
      [18, 2.1],
      [17, 2.2],
      [16, 3.5],
      [15, 4.4],
      [14, 4.6],
      [13, 3.9],
      [12, 3.8],
      [11, 4.4],
      [10, 3.5],
      [9, 2.9],
      [8, 3.25],
      [7, 3.8],
      [6, 3.9],
      [5, 4.1],
      [4, 4.2],
      [3, 4.5],
      [2, 3.9],
      [1, 3.8],
    ],
    "sad": <List<double>>[
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
    ],
    "angry": <List<double>>[
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
    ]
  }
];

class FacialDistribution extends StatelessWidget {
  const FacialDistribution({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CounselingRecordController counselingRecordController =
        context.watch<CounselingRecordController>();
    int currentIndex = counselingRecordController.currentIndex;
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
                color: kSelectedContainerColor, text: "중립", isSquare: true),
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
            percent: currentIndex == 0 ? 69 : 48,
            color: kMainColor,
            dataset: LineChartRawDataSet(
                title: "--",
                color: kMainColor,
                values: facial[currentIndex]["happy"]),
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
            percent: currentIndex == 0 ? 6 : 8,
            color: Colors.yellow,
            dataset: LineChartRawDataSet(
                title: "--",
                color: Colors.yellow,
                values: facial[currentIndex]["sad"]),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 5,
          child: FacialInfoCard(
            title: '분노',
            amount: "340",
            svgSrc: "assets/icons/smile.svg",
            percent: currentIndex == 0 ? 5 : 8,
            color: Colors.red,
            dataset: LineChartRawDataSet(
                title: "--",
                color: Colors.red,
                values: facial[currentIndex]["angry"]),
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
