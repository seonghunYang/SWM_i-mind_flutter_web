import 'package:ai_counseling_platform/model/linechart_metadata.dart';
import 'package:ai_counseling_platform/model/linechart_rawdata.dart';
import 'package:ai_counseling_platform/model/radarchart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/dashboard_bar_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/line_area_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/processed_video.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/stat_analysis_card.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/stats_radar_charts.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/screens/dashboard_counseling_record_manage_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../constants.dart';

class DemoCustomRecordPage extends StatefulWidget {
  const DemoCustomRecordPage({Key? key}) : super(key: key);

  @override
  State<DemoCustomRecordPage> createState() => _DemoCustomRecordPageState();
}

class _DemoCustomRecordPageState extends State<DemoCustomRecordPage> {
  final ScrollController _scrollController = ScrollController();
  late VideoPlayerController _videoPlayerController;
  bool isReadyVideoPlay = false;
  int videoSeconds = 0;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      "assets/video/test6.mp4",
    )..initialize().then((_) {
        setState(() {
          isReadyVideoPlay = true;
          videoSeconds = _videoPlayerController.value.duration.inSeconds;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _videoPlayerController.dispose();
  }

  void playingVideo() {
    setState(() {
      _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play();
    });
  }

  Future pointVideoDuration(int seconds) async {
    int min = seconds ~/ 60;
    seconds %= 60;
    Duration nextPosition = Duration(minutes: min, seconds: seconds);
    await _videoPlayerController.seekTo(nextPosition);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
                flex: 4,
                child: Card(
                  child: Builder(builder: (context) {
                    if (isReadyVideoPlay) {
                      return Container(
                        child: ProcessedVideo(
                          videoPlayerController: _videoPlayerController,
                          onTap: playingVideo,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                )),
            SizedBox(
              width: defaultPadding * 1.5,
            ),
            Expanded(
              flex: 5,
              child: Card(
                elevation: 2,
                child: Container(
                  height: 300,
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "핵심지표",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Tooltip(
                            message: "ㅁㄴㅇ",
                            decoration: BoxDecoration(color: Colors.black87),
                            child: Icon(
                              Icons.info_outline,
                              color: kMainColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Expanded(
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
                                ],
                                rawDatasets: [
                                  RadarChartRawDataSet(
                                    title: 'recent',
                                    color: kSelectedDashboardTextColor,
                                    values: [
                                      10,
                                      8,
                                      9,
                                      10,
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
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: defaultPadding * 2,
        ),
        StatAnalysisCard(
          singleMainContentFlex: 2,
          singleSubContentFlex: 1,
          videoSeconds: videoSeconds,
          videoPlayerController: _videoPlayerController,
          pointVideoDuration: pointVideoDuration,
          title: "즐거움 및 지속성/몰입도 지표분석",
          isTooltip: false,
          tooltipMessage: "ㅁㅁ",
          hintMessageList: [
            "- 대표행동의 반복 패턴과 지속 시간을 통해 아이의 지속성/몰입도를 알 수 있습니다. *대표행동: 영상 내에서 가장 많은 빈도를 보이는 행동",
            "- 데표행동의 최장지속 시간은 아이의 놀이 지속성을 유추해낼 수 있습니다."
          ],
          singleMainContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "아이 감정 시간대별 분포도",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: defaultPadding * 0.5,
                      ),
                      Tooltip(
                        padding: EdgeInsets.all(defaultPadding),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.bold),
                        message: "즐거움 : 9\n28% < 행복 감정의 비율(29.4%) <= 30%",
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Icon(
                          Icons.info_outline,
                          color: kMainColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(children: [
                    Row(
                      children: [
                        ChartIndicator(
                            color: kTextColor, text: "행복", isSquare: true),
                        SizedBox(
                          width: defaultPadding,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ChartIndicator(
                            color: kSelectedDashboardTextColor,
                            text: "침착",
                            isSquare: true),
                        SizedBox(
                          width: defaultPadding,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ChartIndicator(
                            color: Colors.yellow, text: "슬픔", isSquare: true),
                        SizedBox(
                          width: defaultPadding,
                        ),
                      ],
                    ),
                  ]),
                ],
              ),
              SizedBox(
                height: defaultPadding * 2,
              ),
              Container(
                height: 200,
                child: LineAreaChart(
                  onTap: (value) {},
                  lineChartMetaData: LineChartMetaData(
                    minX: 0,
                    maxX: _videoPlayerController.value.duration.inSeconds
                        .toDouble(),
                    minY: 0,
                    maxY: 10,
                    leftTitle: (value) {
                      switch (value.toInt()) {
                        case 20:
                          return '0.2';
                        case 40:
                          return '0.4';
                        case 60:
                          return '0.6';
                        case 80:
                          return '0.8';
                        case 100:
                          return '1.0';
                      }
                      return '';
                    },
                    bottomTitle: (value) {
                      switch (value.toInt()) {
                        case 60:
                          return '1분';
                        case 120:
                          return '2분';
                        case 240:
                          return '4분';
                        case 360:
                          return '6분';
                        case 480:
                          return '8분';
                        case 600:
                          return '10분';
                      }
                      return '';
                    },
                  ),
                  lineChartRawDataSets: [
                    LineChartRawDataSet(
                      title: "--",
                      color: kSelectedDashboardTextColor,
                      values: List<List<double>>.generate(videoSeconds,
                          (index) => [index.toDouble(), (index * index) % 8]),
                    ),
                    LineChartRawDataSet(
                        title: "--",
                        color: kTextColor,
                        values: List<List<double>>.generate(
                            videoSeconds,
                            (index) =>
                                [index.toDouble(), (index * index) % 9])),
                    LineChartRawDataSet(
                        title: "--",
                        color: Colors.yellow,
                        values: List<List<double>>.generate(
                            videoSeconds,
                            (index) =>
                                [index.toDouble(), (index * index) % 5])),
                  ],
                ),
              ),
            ],
          ),
          singleSubContent: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 220,
                height: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "대표행동 지속시간 비교",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          width: defaultPadding * 0.5,
                        ),
                        Tooltip(
                          padding: EdgeInsets.all(defaultPadding),
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontWeight: FontWeight.bold),
                          message:
                              "지속성/몰입도 : 9\n1분 40초 < 대표행동 지속시간(2분 4초) <= 2분 10초",
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Icon(
                            Icons.info_outline,
                            color: kMainColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Expanded(
                      child: DashboardBarChart(
                        gridData: FlGridData(
                            show: true,
                            drawHorizontalLine: true,
                            drawVerticalLine: false),
                        barDataList: [
                          [0, 124],
                          [1, 93],
                        ],
                        maxY: 220,
                        getLeftTitle: (value) {
                          switch (value.toInt()) {
                            case 60:
                              return '1분';
                            case 120:
                              return '2분';
                            case 180:
                              return '3분';
                            case 120:
                              return '2분';
                            case 180:
                              return '3';
                          }
                          return '';
                        },
                        getBottomTitle: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return '아이';
                            case 1:
                              return '센터평균';

                            default:
                              return '';
                          }
                        },
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          String profile;
                          switch (group.x.toInt()) {
                            case 0:
                              profile = '아이';
                              break;
                            case 1:
                              profile = '센터평균';
                              break;
                            default:
                              throw Error();
                          }
                          int minute = rod.y ~/ 60;
                          int seconds = rod.y.toInt() % 60;
                          return BarTooltipItem(
                            profile + '\n',
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "$minute분 $seconds초",
                                style: TextStyle(
                                  color: Color(0xff3FC37C),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
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
        StatAnalysisCard(
          singleMainContentFlex: 3,
          singleSubContentFlex: 2,
          videoSeconds: videoSeconds,
          videoPlayerController: _videoPlayerController,
          pointVideoDuration: pointVideoDuration,
          title: "주도성 및 민감도 분석",
          tooltipMessage: "ㅁㄴ",
          isTooltip: false,
          hintMessageList: [
            "- 발화의 비율을 통해 놀이에서 주도성을 파악할 수 있습니다.",
            "- 부모와 아이의 거리 편차를 이용하여 부모-아이 관계를 유추할 수 있습니다."
          ],
          singleMainContent: Column(
            children: [
              Row(
                children: [
                  Text(
                    "부모-아이 발화 주도권 비율",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    width: defaultPadding * 0.5,
                  ),
                  Tooltip(
                    padding: EdgeInsets.all(defaultPadding),
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.bold),
                    message: "주도성 : 9\n35% < 부모-아이 발화비율 편차(39.6%) <= 40%",
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Icon(
                      Icons.info_outline,
                      color: kMainColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Container(
                height: 200,
                width: 500,
                child: PercentBar(),
              )
            ],
          ),
          singleSubContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "부모-아이 거리 편차 분포",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    width: defaultPadding * 0.5,
                  ),
                  Tooltip(
                    padding: EdgeInsets.all(defaultPadding),
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.bold),
                    message: "유대감 : 9\n0.05 < 부모-아이 거리평균(0.06) <= 0.1",
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Icon(
                      Icons.info_outline,
                      color: kMainColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultPadding * 2,
              ),
              Container(
                height: 200,
                child: LineAreaChart(
                  onTap: (value) {},
                  lineChartMetaData: LineChartMetaData(
                    minX: 0,
                    maxX: 10,
                    minY: 0,
                    maxY: 10,
                    leftTitle: (value) {
                      switch (value.toInt()) {
                        case 2:
                          return '20';
                        case 4:
                          return '40';
                        case 6:
                          return '60';
                        case 8:
                          return '80';
                        case 10:
                          return '100';
                      }
                      return '';
                    },
                    bottomTitle: (value) {
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
