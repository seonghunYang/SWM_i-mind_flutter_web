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
        FacialInfoCard(
          title: '기쁨',
          amount: "340",
          svgSrc: "assets/icons/smile.svg",
          percent: 26.3,
          color: kSelectedContainerColor,
        ),
        SizedBox(
          height: defaultPadding * 1.5,
        ),
        FacialInfoCard(
          title: '슬픔',
          amount: "340",
          svgSrc: "assets/icons/smile.svg",
          percent: 26.3,
          color: kMainColor,
        ),
        SizedBox(
          height: defaultPadding * 1.5,
        ),
        FacialInfoCard(
          title: '화남',
          amount: "340",
          svgSrc: "assets/icons/smile.svg",
          percent: 26.3,
          color: Colors.yellow,
        ),
      ],
    );
  }
}
