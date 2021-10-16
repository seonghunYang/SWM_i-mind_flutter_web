import 'package:ai_counseling_platform/controllers/menu_controller.dart';
import 'package:ai_counseling_platform/model/linechart_metadata.dart';
import 'package:ai_counseling_platform/model/linechart_rawdata.dart';
import 'package:ai_counseling_platform/model/radarchart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/bottom_info_appbar.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/counseling_report_dialog.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/line_area_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/processed_video.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/profile_info_cell.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/stats_radar_charts.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../constants.dart';

class DashboardCounselingRecordManageScreen extends StatefulWidget {
  const DashboardCounselingRecordManageScreen({Key? key}) : super(key: key);

  @override
  State<DashboardCounselingRecordManageScreen> createState() =>
      _DashboardCounselingRecordManageScreenState();
}

class _DashboardCounselingRecordManageScreenState
    extends State<DashboardCounselingRecordManageScreen> {
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
      child: Card(
        elevation: 0,
        child: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(defaultPadding * 2),
            child: SizedBox(
              width: 80,
              height: 80,
              child: FloatingActionButton(
                backgroundColor: kMainColor,
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CounselingReportDialog();
                      });
                },
                child: Text(
                  "일지\n작성",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          appBar: BottomInfoAppBar(
            onTap: () {
              context.read<MenuController>().updateMenuIndex(1);
            },
            title: "01100",
            infoList: [
              ProfileInfoCell(
                title: "자녀 이름",
                info: "양성훈",
              ),
              ProfileInfoCell(
                title: "상담종류",
                info: "놀이영상분석",
              ),
              ProfileInfoCell(
                title: "상담날짜",
                info: "2021-03-16",
              ),
            ],
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Card(
                            child: Container(
                              child: ProcessedVideo(),
                            ),
                          )),
                      SizedBox(
                        width: defaultPadding * 1.5,
                      ),
                      Expanded(
                        flex: 3,
                        child: Card(
                          elevation: 2,
                          child: Container(
                            height: 300,
                            padding: EdgeInsets.all(defaultPadding),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
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
                                Expanded(
                                  flex: 1,
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
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Card(
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "상호 감정 분석",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            height: defaultPadding * 2,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "주요 감정",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        Row(
                                          children: [
                                            ChartIndicator(
                                                color: kTextColor,
                                                text: "보호자",
                                                isSquare: true),
                                            SizedBox(
                                              width: defaultPadding,
                                            ),
                                            ChartIndicator(
                                                color:
                                                    kSelectedDashboardTextColor,
                                                text: "자녀",
                                                isSquare: true),
                                            SizedBox(
                                              width: defaultPadding * 2,
                                            ),
                                            DropdownButton(
                                              underline:
                                                  DropdownButtonHideUnderline(
                                                      child: Container()),
                                              value: 0,
                                              items: [
                                                DropdownMenuItem(
                                                  value: 0,
                                                  child: Text(
                                                    "행복",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: 1,
                                                  child: Text("분노"),
                                                ),
                                                DropdownMenuItem(
                                                  value: 2,
                                                  child: Text("기쁨"),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: defaultPadding * 2,
                                    ),
                                    Container(
                                      height: 200,
                                      child: LineAreaChart(
                                        lineChartMetaData: LineChartMetaData(
                                          minX: 0,
                                          maxX: 10,
                                          minY: 0,
                                          maxY: 10,
                                          leftTitle: (value) {
                                            switch (value.toInt()) {
                                              case 2:
                                                return '0.2';
                                              case 4:
                                                return '0.4';
                                              case 6:
                                                return '0.6';
                                              case 8:
                                                return '0.8';
                                              case 10:
                                                return '1.0';
                                            }
                                            return '';
                                          },
                                          bottomTitle: (value) {
                                            switch (value.toInt()) {
                                              case 2:
                                                return '2분';
                                              case 4:
                                                return '4분';
                                              case 6:
                                                return '6분';
                                              case 8:
                                                return '8분';
                                              case 10:
                                                return '10분';
                                            }
                                            return '';
                                          },
                                        ),
                                        lineChartRawDataSets: [
                                          LineChartRawDataSet(
                                            title: "--",
                                            color: kSelectedDashboardTextColor,
                                            values: [
                                              [0, 2],
                                              [0.5, 4],
                                              [1, 6],
                                              [1.5, 2],
                                              [2, 2],
                                              [2.5, 5],
                                              [3, 7.2],
                                              [3.5, 8.3],
                                              [4, 2.1],
                                              [4.5, 2.5],
                                              [5, 3],
                                              [5.5, 4.4],
                                              [6, 4.6],
                                              [6.5, 7],
                                              [7, 7.4],
                                              [7.5, 8.9],
                                              [8, 9.4],
                                              [8.5, 9.4],
                                              [9, 6.4],
                                              [9.5, 3.2],
                                              [10.0, 1, 2]
                                            ],
                                          ),
                                          LineChartRawDataSet(
                                            title: "--",
                                            color: kTextColor,
                                            values: [
                                              [0, 4],
                                              [0.5, 2],
                                              [1, 2],
                                              [1.5, 6],
                                              [2, 5],
                                              [2.5, 2],
                                              [3, 8.3],
                                              [3.5, 7.2],
                                              [4, 2.1],
                                              [4.5, 5],
                                              [5, 3],
                                              [5.5, 1],
                                              [6, 9],
                                              [6.5, 8],
                                              [7, 9],
                                              [7.5, 10],
                                              [8, 9.2],
                                              [8.5, 3],
                                              [9, 6.5],
                                              [9.5, 1],
                                              [10.0, 1, 2]
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "분석 신뢰도",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "90%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "긍정/부정 분석",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: defaultPadding * 2,
                                    ),
                                    Container(
                                      height: 200,
                                      child: LineAreaChart(
                                        lineChartMetaData: LineChartMetaData(
                                          minX: 0,
                                          maxX: 10,
                                          minY: 0,
                                          maxY: 10,
                                          leftTitle: (value) {
                                            switch (value.toInt()) {
                                              case 2:
                                                return '0.2';
                                              case 4:
                                                return '0.4';
                                              case 6:
                                                return '0.6';
                                              case 8:
                                                return '0.8';
                                              case 10:
                                                return '1.0';
                                            }
                                            return '';
                                          },
                                          bottomTitle: (value) {
                                            switch (value.toInt()) {
                                              case 2:
                                                return '2분';
                                              case 4:
                                                return '4분';
                                              case 6:
                                                return '6분';
                                              case 8:
                                                return '8분';
                                              case 10:
                                                return '10분';
                                            }
                                            return '';
                                          },
                                        ),
                                        lineChartRawDataSets: [
                                          LineChartRawDataSet(
                                            title: "--",
                                            color: kSelectedDashboardTextColor,
                                            values: [
                                              [0, 2],
                                              [0.5, 4],
                                              [1, 6],
                                              [1.5, 2],
                                              [2, 2],
                                              [2.5, 5],
                                              [3, 7.2],
                                              [3.5, 8.3],
                                              [4, 2.1],
                                              [4.5, 2.5],
                                              [5, 3],
                                              [5.5, 4.4],
                                              [6, 4.6],
                                              [6.5, 7],
                                              [7, 7.4],
                                              [7.5, 8.9],
                                              [8, 9.4],
                                              [8.5, 9.4],
                                              [9, 6.4],
                                              [9.5, 3.2],
                                              [10.0, 1, 2]
                                            ],
                                          ),
                                          LineChartRawDataSet(
                                            title: "--",
                                            color: kTextColor,
                                            values: [
                                              [0, 4],
                                              [0.5, 2],
                                              [1, 2],
                                              [1.5, 6],
                                              [2, 5],
                                              [2.5, 2],
                                              [3, 8.3],
                                              [3.5, 7.2],
                                              [4, 2.1],
                                              [4.5, 5],
                                              [5, 3],
                                              [5.5, 1],
                                              [6, 9],
                                              [6.5, 8],
                                              [7, 9],
                                              [7.5, 10],
                                              [8, 9.2],
                                              [8.5, 3],
                                              [9, 6.5],
                                              [9.5, 1],
                                              [10.0, 1, 2]
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    EmotionDistributionCard(
                                      title: "보호자",
                                      positivePercent: 73.4,
                                      negativePercent: 26.6,
                                    ),
                                    SizedBox(
                                      height: defaultPadding,
                                    ),
                                    EmotionDistributionCard(
                                      title: "자녀",
                                      positivePercent: 37.7,
                                      negativePercent: 63.3,
                                    ),
                                  ],
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                          InputDatePickerFormField(
                            firstDate: DateTime.utc(2010, 10, 16),
                            lastDate: DateTime.utc(2030, 3, 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmotionDistributionCard extends StatelessWidget {
  const EmotionDistributionCard({
    Key? key,
    required this.title,
    required this.positivePercent,
    required this.negativePercent,
  }) : super(key: key);
  final String title;
  final double positivePercent;
  final double negativePercent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.subtitle1),
        RichText(
          text: TextSpan(
            text: "긍정: $positivePercent%",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.blue),
            children: [
              TextSpan(text: " / ", style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: "부정: $negativePercent%",
                  style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    Key? key,
    required this.title,
    required this.score,
  }) : super(key: key);

  final String title;
  final dynamic score;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title: ",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Text("$score", style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}
