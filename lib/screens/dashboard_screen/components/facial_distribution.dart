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
                color: kSelectedContainerColor, text: "행복", isSquare: true),
            ChartIndicator(color: kMainColor, text: "슬픔", isSquare: true),
          ],
        ),
        SizedBox(
          height: defaultPadding * 1.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ChartIndicator(color: Colors.yellow, text: "화남", isSquare: true),
            ChartIndicator(color: Colors.red, text: "보통", isSquare: true),
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
            title: '기쁨',
            amount: "340",
            svgSrc: "assets/icons/smile.svg",
            percent: 26.3,
            color: kSelectedContainerColor,
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
            color: kMainColor,
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
            color: Colors.yellow,
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
