import 'package:ai_counseling_platform/model/linechart_metadata.dart';
import 'package:ai_counseling_platform/model/linechart_rawdata.dart';
import 'package:ai_counseling_platform/model/radarchart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/block_container.dart';
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

const Map actionTime = {
  "time": 138,
  "avg_time": 0,
};

const List<Map> indicator = [
  {
    "indicator": [8, 7, 6, 5],
    "result": [43, 139, 18.6, 0.47],
  },
  {
    "indicator": [7, 5, 6, 5],
    "result": [43, 107, 18.6, 0.47],
  },
];
const Map talkPercentage = {"child": 59.3};

class DemoCustomRecordPage extends StatefulWidget {
  const DemoCustomRecordPage({Key? key, required this.currentIndex})
      : super(key: key);
  final int currentIndex;

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
      "assets/video/test4.mp4",
    )..initialize().then((_) {
        setState(() {
          isReadyVideoPlay = true;
          videoSeconds = _videoPlayerController.value.duration.inSeconds;
          print(videoSeconds);
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
    return DefaultTabController(
      length: 1,
      initialIndex: 0,
      child: Column(
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
                                        indicator[widget.currentIndex]
                                            ["indicator"][0],
                                        indicator[widget.currentIndex]
                                            ["indicator"][1],
                                        indicator[widget.currentIndex]
                                            ["indicator"][2],
                                        indicator[widget.currentIndex]
                                            ["indicator"][3],
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
                                        title: "즐거움",
                                        score: indicator[widget.currentIndex]
                                            ["indicator"][0],
                                      ),
                                      ScoreCard(
                                        title: "지속성/몰압도",
                                        score: indicator[widget.currentIndex]
                                            ["indicator"][1],
                                      ),
                                      ScoreCard(
                                        title: "주도성",
                                        score: indicator[widget.currentIndex]
                                            ["indicator"][2],
                                      ),
                                      ScoreCard(
                                        title: "밀착도",
                                        score: indicator[widget.currentIndex]
                                            ["indicator"][3],
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
          Align(
            alignment: Alignment.centerLeft,
            child: Card(
              elevation: 0.5,
              margin: EdgeInsets.zero,
              child: Container(
                width: 150,
                height: 50,
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: kSelectedDashboardTextColor,
                  indicatorColor: kSelectedDashboardTextColor,
                  tabs: [
                    Text(
                      '지표분석 결과',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 0.5,
            margin: EdgeInsets.zero,
            child: Container(
                width: double.infinity,
                height: 850,
                child: TabBarView(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: defaultPadding * 2,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: StatAnalysisCard(
                                isTooltip: true,
                                singleMainContentFlex: 2,
                                singleSubContentFlex: 0,
                                tooltipMessage: "asd",
                                title:
                                    "지속성/몰입도 : ${indicator[widget.currentIndex]["indicator"][1]}점",
                                videoSeconds: videoSeconds,
                                videoPlayerController: _videoPlayerController,
                                pointVideoDuration: pointVideoDuration,
                                singleSubContent: Container(),
                                singleMainContent: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "설정 분석로직:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: defaultPadding,
                                              ),
                                              BlockContainer(text: "아이"),
                                              SizedBox(
                                                width: defaultPadding * 0.5,
                                              ),
                                              BlockContainer(
                                                  text: "대표행동(말하기, 잡기, 듣기)"),
                                              SizedBox(
                                                width: defaultPadding * 0.5,
                                              ),
                                              BlockContainer(text: "지속시간 구하기"),
                                              SizedBox(
                                                width: defaultPadding * 0.5,
                                              ),
                                              BlockContainer(
                                                  text: widget.currentIndex == 0
                                                      ? "최대값 비교"
                                                      : "평균값 비교"),
                                            ],
                                          ),
                                          SizedBox(
                                            height: defaultPadding * 0.5,
                                          ),
                                          SizedBox(
                                            height: defaultPadding * 2,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "분석 값: ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                  "${indicator[widget.currentIndex]["result"][1]}초",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                              Text(
                                                  widget.currentIndex == 0
                                                      ? "(130초 < 대표행동 지속시간(${indicator[widget.currentIndex]["result"][1]}초) <= 150초 => ${indicator[widget.currentIndex]["indicator"][1]}점)"
                                                      : "(90초 < 대표행동 지속시간(${indicator[widget.currentIndex]["result"][1]}초) <= 110초 => ${indicator[widget.currentIndex]["indicator"][1]}점)",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: Colors.grey))
                                            ],
                                          ),
                                          SizedBox(
                                            height: defaultPadding * 3,
                                          ),
                                          RichText(
                                              text: TextSpan(
                                                  text: "해석그래프",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  children: [
                                                TextSpan(
                                                  text: "(대표행동 지속시간 비교)",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                              ])),
                                          SizedBox(
                                            height: defaultPadding * 3,
                                          ),
                                          Container(
                                            height: 200,
                                            child: DashboardBarChart(
                                              gridData: FlGridData(
                                                  show: true,
                                                  drawHorizontalLine: true,
                                                  drawVerticalLine: false),
                                              barDataList: [
                                                [
                                                  0,
                                                  indicator[widget.currentIndex]
                                                          ["result"][1] -
                                                      1,
                                                ],
                                                [1, actionTime["avg_time"]],
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
                                              getTooltipItem: (group,
                                                  groupIndex, rod, rodIndex) {
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
                                                int seconds =
                                                    rod.y.toInt() % 60;
                                                return BarTooltipItem(
                                                  profile + '\n',
                                                  TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          "$minute분 $seconds초",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff3FC37C),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                            ),
                            Expanded(
                              flex: 1,
                              child: StatAnalysisCard(
                                isTooltip: true,
                                singleMainContentFlex: 2,
                                singleSubContentFlex: 0,
                                tooltipMessage: "asd",
                                title:
                                    "즐거움 : ${indicator[widget.currentIndex]["indicator"][0]}점",
                                videoSeconds: videoSeconds,
                                videoPlayerController: _videoPlayerController,
                                pointVideoDuration: pointVideoDuration,
                                singleSubContent: Container(),
                                singleMainContent: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "설정 분석로직:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: defaultPadding,
                                        ),
                                        BlockContainer(text: "아이"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "대표감정(행복)"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "비율 구하기"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "값 비교"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: defaultPadding * 2,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "분석 값: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${indicator[widget.currentIndex]["result"][0]}%",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                        Text(
                                            widget.currentIndex == 0
                                                ? "(40% < 대표감정비율(${indicator[widget.currentIndex]["result"][0]}%) <= 50% => ${indicator[widget.currentIndex]["indicator"][0]}점)"
                                                : "(30% < 대표감정비율(${indicator[widget.currentIndex]["result"][0]}%) <= 45% => ${indicator[widget.currentIndex]["indicator"][0]}점)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.grey))
                                      ],
                                    ),
                                    SizedBox(
                                      height: defaultPadding * 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                                text: "해석그래프",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                children: [
                                              TextSpan(
                                                text: "(아이 감정 시간대별 분포도)",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ])),
                                        Row(
                                          children: List.generate(
                                              emotionChild["emotionCategory"]
                                                  .length,
                                              (index) => Row(
                                                    children: [
                                                      ChartIndicator(
                                                          color:
                                                              colorList[index],
                                                          text: emotionChild[
                                                                  "emotionCategory"]![
                                                              index],
                                                          isSquare: true),
                                                      SizedBox(
                                                        width: defaultPadding,
                                                      ),
                                                    ],
                                                  )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: defaultPadding * 3,
                                    ),
                                    Container(
                                      height: 200,
                                      child: LineAreaChart(
                                        onTap: (value) {},
                                        lineChartMetaData: LineChartMetaData(
                                          minX: 0,
                                          maxX: 70,
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
                                              case 15:
                                                return '30초';
                                              case 30:
                                                return '1분';
                                              case 45:
                                                return '1분 30초';
                                              case 60:
                                                return '2분';
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
                                        lineChartRawDataSets: List.generate(
                                          emotionChild["dataList"].length,
                                          (index) => LineChartRawDataSet(
                                            title: "--",
                                            color: colorList[index],
                                            values: emotionChild["dataList"]
                                                [index],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: defaultPadding * 2,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: StatAnalysisCard(
                                isTooltip: true,
                                singleMainContentFlex: 3,
                                singleSubContentFlex: 0,
                                videoSeconds: videoSeconds,
                                videoPlayerController: _videoPlayerController,
                                pointVideoDuration: pointVideoDuration,
                                title:
                                    "주도성 : ${indicator[widget.currentIndex]["indicator"][2]}점",
                                tooltipMessage: "ㅁㄴ",
                                // hintMessageList: [
                                //   "- 발화의 비율을 통해 놀이에서 주도성을 파악할 수 있습니다.",
                                //   "- 부모와 아이의 거리 편차를 이용하여 부모-아이 관계를 유추할 수 있습니다."
                                // ],
                                singleMainContent: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "설정 분석로직:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: defaultPadding,
                                        ),
                                        BlockContainer(text: "아이-부모"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "대표행동(말하기)"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "비율 구하기"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "차이 비교"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: defaultPadding * 2,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "분석 값: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${indicator[widget.currentIndex]["result"][2]}%",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                        Text(
                                            " (+10% < 대표행동 차이 비교(${indicator[widget.currentIndex]["result"][2]}%) <= +20% => ${indicator[widget.currentIndex]["indicator"][2]}점)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.grey))
                                      ],
                                    ),
                                    SizedBox(
                                      height: defaultPadding * 3,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: "해석그래프",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                            children: [
                                          TextSpan(
                                            text: "(대표행동(말하기) 비율 비교)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ])),
                                    SizedBox(
                                      height: defaultPadding * 3,
                                    ),
                                    Container(
                                      height: 200,
                                      width: 500,
                                      child: PercentBar(
                                        childPercentage:
                                            talkPercentage['child'],
                                      ),
                                    )
                                  ],
                                ),
                                singleSubContent: Container(),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: StatAnalysisCard(
                                  singleMainContent: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "설정 분석로직:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: defaultPadding,
                                          ),
                                          BlockContainer(text: "아이-부모"),
                                          SizedBox(
                                            width: defaultPadding * 0.5,
                                          ),
                                          BlockContainer(text: "위치"),
                                          SizedBox(
                                            width: defaultPadding * 0.5,
                                          ),
                                          BlockContainer(text: "거리 구하기"),
                                          SizedBox(
                                            width: defaultPadding * 0.5,
                                          ),
                                          BlockContainer(text: "평균 비교"),
                                        ],
                                      ),
                                      SizedBox(
                                        height: defaultPadding * 2,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "분석 값: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Text(
                                              "${indicator[widget.currentIndex]["indicator"][3]}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                          Text(
                                              " (0.4 <= 평균 거리 비교(${indicator[widget.currentIndex]["result"][3]}) < 0.5 => ${indicator[widget.currentIndex]["indicator"][3]}점)",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color: Colors.grey))
                                        ],
                                      ),
                                      SizedBox(
                                        height: defaultPadding * 3,
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text: "해석그래프",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              children: [
                                            TextSpan(
                                              text: "(부모-아이 거리 변화량)",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ])),
                                      SizedBox(
                                        height: defaultPadding * 3,
                                      ),
                                      Container(
                                        height: 200,
                                        child: LineAreaChart(
                                          onTap: (value) {},
                                          lineChartMetaData: LineChartMetaData(
                                            minX: 0,
                                            maxX: 70,
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
                                                case 15:
                                                  return '30초';
                                                case 30:
                                                  return '1분';
                                                case 45:
                                                  return '1분 30초';
                                                case 60:
                                                  return '2분';
                                              }
                                              return '';
                                            },
                                          ),
                                          lineChartRawDataSets: [
                                            LineChartRawDataSet(
                                              title: "--",
                                              color:
                                                  kSelectedDashboardTextColor,
                                              values: [
                                                [0, 2],
                                                [3, 4],
                                                [6, 6],
                                                [9, 2],
                                                [12, 2],
                                                [15, 5],
                                                [18, 7.2],
                                                [21, 8.3],
                                                [24, 2.1],
                                                [27, 2.5],
                                                [30, 3],
                                                [33, 4.4],
                                                [36, 4.6],
                                                [39, 7],
                                                [42, 7.4],
                                                [45, 8.9],
                                                [48, 9.4],
                                                [51, 9.4],
                                                [54, 6.4],
                                                [57, 3.2],
                                                [60, 5],
                                                [63, 4],
                                                [66, 4.3],
                                                [69, 4.7],
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  isTooltip: true,
                                  singleMainContentFlex: 3,
                                  singleSubContentFlex: 0,
                                  videoSeconds: videoSeconds,
                                  videoPlayerController: _videoPlayerController,
                                  pointVideoDuration: pointVideoDuration,
                                  title:
                                      "밀착도 : ${indicator[widget.currentIndex]["indicator"][3]}점",
                                  tooltipMessage: "ㅁㄴ",
                                  singleSubContent: Container(),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
