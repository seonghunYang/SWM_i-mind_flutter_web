import 'package:ai_counseling_platform/model/radarchart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/bottom_info_appbar.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/profile_info_cell.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/stats_radar_charts.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'dashboard_counseling_record_manage_screen.dart';

class DashboardCounselingReportScreen extends StatefulWidget {
  const DashboardCounselingReportScreen({Key? key}) : super(key: key);

  @override
  State<DashboardCounselingReportScreen> createState() =>
      _DashboardCounselingReportScreenState();
}

class _DashboardCounselingReportScreenState
    extends State<DashboardCounselingReportScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffd1f8e4).withOpacity(0.3),
      padding: EdgeInsets.only(
        left: defaultPadding * 15,
        right: defaultPadding * 15,
        top: defaultPadding * 2,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BottomInfoAppBar(
          isLeading: false,
          onTap: () {},
          title: "상담보고서",
          infoList: [
            ProfileInfoCell(
              title: "아이 이름",
              info: "양성훈",
            ),
            ProfileInfoCell(
              title: "아이 나이",
              info: "41개월",
            ),
            ProfileInfoCell(
              title: "아이 성별",
              info: "여아",
            ),
            ProfileInfoCell(
              title: "부모 이름",
              info: "김나은",
            ),
            ProfileInfoCell(
              title: "부모 관계",
              info: "아빠",
            ),
            ProfileInfoCell(
              title: "상담 날짜",
              info: "2021-08-16",
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 3, vertical: defaultPadding * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "관찰지표",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 220,
                                child: StatsRadarChart(
                                  indicators: [
                                    ChartIndicator(
                                      color: kSelectedDashboardTextColor,
                                      text: "분석 점수",
                                      isSquare: false,
                                      size: 12,
                                    ),
                                    ChartIndicator(
                                      color: kSelectedContainerColor,
                                      text: "또래 점수평균",
                                      isSquare: false,
                                      size: 12,
                                    ),
                                  ],
                                  rawDatasets: [
                                    RadarChartRawDataSet(
                                      title: 'mean',
                                      color: kSelectedContainerColor,
                                      values: [
                                        7,
                                        6,
                                        7,
                                        6,
                                        7,
                                      ],
                                    ),
                                    RadarChartRawDataSet(
                                      title: 'recent',
                                      color: kSelectedDashboardTextColor,
                                      values: [
                                        10,
                                        8,
                                        9,
                                        10,
                                        7,
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: defaultPadding * 3),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ScoreCard(
                                      title: "민감도",
                                      score: 9,
                                    ),
                                    ScoreCard(
                                      title: "반복하기",
                                      score: 9,
                                    ),
                                    ScoreCard(
                                      title: "즐거움",
                                      score: 9,
                                    ),
                                    ScoreCard(
                                      title: "주도성",
                                      score: 9,
                                    ),
                                    ScoreCard(
                                      title: "지속성/몰입도",
                                      score: 9,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "아이 보완점",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 2,
                          vertical: defaultPadding * 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "주도성: 부모-아이 발화 비율",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                SizedBox(
                                  height: defaultPadding * 2,
                                ),
                                PercentBar(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: defaultPadding * 2,
                          ),
                          Text(
                            '시우의 표정이나 대화를 잘 관찰해보면, 기본적으로 아이는 자신이 생각한 스토리와 놀이 계획을 가지고 있고 그것을 표현하고 싶어하는 아이었어요. 하지만 실제 놀이에서는 결국 엄마가 제시하는 방식대로 협조하며 따라주는 경우가 더 많았어요. 엄마가 겨울왕국 피규어를 배치하는 것을 가만히 지켜보며 그냥 수긍하고 따라가거나, 신나게 놀이를 하다가도 엄마가 "계산해야지, 인사하고" 라는 갑작스러운 제시에 협조하는 점, 사슴과 순록에 대한 질문에 하던 놀이를 멈추고 엄마에게 대답하는 점 등에서 이러한 모습을 엿볼 수 있었어요.',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(""),
                          Text(
                            '시우가 워낙 적극적이고 명랑하다보니 그냥 아이가 잘 놀고 있구나 라고 느낄 수 있어요. 하지만  자세히 보면, 전체 놀이에서 아이의 놀이보다는 엄마가 끌고 가는 놀이의 비중이 훨씬 많아요. 아이가 먼저 시작했어도 결국 엄마가 주도하는 방식으로 가거나 엄마가 끝을 내버리는 상황이 자주 관찰되었어요. ',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(""),
                          Text(
                            '일상생활에서는 아이에게 훈육도 해야하고 어느 정도 규칙과 제한이 있을 수 있어요. 하지만 아이가 자유롭게 끌고 나가야할 자유놀이 시간에서마저, 아이가 주도할 수 있는 경험이 너무 없다면 아이는 부모와의 놀이에서 해소되지 못한 욕구를 또래에게 풀려고 하거나, 엄마가 없이 스스로 놀이하는 것은 어려워하고 자꾸만 누군가를 매어두려고 하는 놀이패턴을 보일 수 밖에 없어요. 아이에게 놀이는 주도성을 연습하고 스트레스를 해소하는 소중한 심리적 공간입니다. 일상생활에서 아이의 협력을 더 많이 얻어내고 싶다면, 놀이에서의 주도권을 아이가 좀 더 가져갈 수 있게 해주세요!',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
