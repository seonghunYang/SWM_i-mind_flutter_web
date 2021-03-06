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
                              "????????????",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              width: defaultPadding,
                            ),
                            Tooltip(
                              message: "?????????",
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
                                      text: "?????? ??????",
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
                                        title: "?????????",
                                        score: indicator[widget.currentIndex]
                                            ["indicator"][0],
                                      ),
                                      ScoreCard(
                                        title: "?????????/?????????",
                                        score: indicator[widget.currentIndex]
                                            ["indicator"][1],
                                      ),
                                      ScoreCard(
                                        title: "?????????",
                                        score: indicator[widget.currentIndex]
                                            ["indicator"][2],
                                      ),
                                      ScoreCard(
                                        title: "?????????",
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
                      '???????????? ??????',
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
                                    "?????????/????????? : ${indicator[widget.currentIndex]["indicator"][1]}???",
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
                                                "?????? ????????????:",
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
                                              BlockContainer(text: "??????"),
                                              SizedBox(
                                                width: defaultPadding * 0.5,
                                              ),
                                              BlockContainer(
                                                  text: "????????????(?????????, ??????, ??????)"),
                                              SizedBox(
                                                width: defaultPadding * 0.5,
                                              ),
                                              BlockContainer(text: "???????????? ?????????"),
                                              SizedBox(
                                                width: defaultPadding * 0.5,
                                              ),
                                              BlockContainer(
                                                  text: widget.currentIndex == 0
                                                      ? "????????? ??????"
                                                      : "????????? ??????"),
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
                                                "?????? ???: ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                  "${indicator[widget.currentIndex]["result"][1]}???",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                              Text(
                                                  widget.currentIndex == 0
                                                      ? "(130??? < ???????????? ????????????(${indicator[widget.currentIndex]["result"][1]}???) <= 150??? => ${indicator[widget.currentIndex]["indicator"][1]}???)"
                                                      : "(90??? < ???????????? ????????????(${indicator[widget.currentIndex]["result"][1]}???) <= 110??? => ${indicator[widget.currentIndex]["indicator"][1]}???)",
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
                                                  text: "???????????????",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  children: [
                                                TextSpan(
                                                  text: "(???????????? ???????????? ??????)",
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
                                                    return '1???';
                                                  case 120:
                                                    return '2???';
                                                  case 180:
                                                    return '3???';
                                                  case 120:
                                                    return '2???';
                                                  case 180:
                                                    return '3';
                                                }
                                                return '';
                                              },
                                              getBottomTitle: (double value) {
                                                switch (value.toInt()) {
                                                  case 0:
                                                    return '??????';
                                                  case 1:
                                                    return '????????????';

                                                  default:
                                                    return '';
                                                }
                                              },
                                              getTooltipItem: (group,
                                                  groupIndex, rod, rodIndex) {
                                                String profile;
                                                switch (group.x.toInt()) {
                                                  case 0:
                                                    profile = '??????';
                                                    break;
                                                  case 1:
                                                    profile = '????????????';
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
                                                          "$minute??? $seconds???",
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
                                    "????????? : ${indicator[widget.currentIndex]["indicator"][0]}???",
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
                                          "?????? ????????????:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: defaultPadding,
                                        ),
                                        BlockContainer(text: "??????"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "????????????(??????)"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "?????? ?????????"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "??? ??????"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: defaultPadding * 2,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "?????? ???: ",
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
                                                ? "(40% < ??????????????????(${indicator[widget.currentIndex]["result"][0]}%) <= 50% => ${indicator[widget.currentIndex]["indicator"][0]}???)"
                                                : "(30% < ??????????????????(${indicator[widget.currentIndex]["result"][0]}%) <= 45% => ${indicator[widget.currentIndex]["indicator"][0]}???)",
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
                                                text: "???????????????",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                children: [
                                              TextSpan(
                                                text: "(?????? ?????? ???????????? ?????????)",
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
                                                return '30???';
                                              case 30:
                                                return '1???';
                                              case 45:
                                                return '1??? 30???';
                                              case 60:
                                                return '2???';
                                              case 360:
                                                return '6???';
                                              case 480:
                                                return '8???';
                                              case 600:
                                                return '10???';
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
                                    "????????? : ${indicator[widget.currentIndex]["indicator"][2]}???",
                                tooltipMessage: "??????",
                                // hintMessageList: [
                                //   "- ????????? ????????? ?????? ???????????? ???????????? ????????? ??? ????????????.",
                                //   "- ????????? ????????? ?????? ????????? ???????????? ??????-?????? ????????? ????????? ??? ????????????."
                                // ],
                                singleMainContent: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "?????? ????????????:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: defaultPadding,
                                        ),
                                        BlockContainer(text: "??????-??????"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "????????????(?????????)"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "?????? ?????????"),
                                        SizedBox(
                                          width: defaultPadding * 0.5,
                                        ),
                                        BlockContainer(text: "?????? ??????"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: defaultPadding * 2,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "?????? ???: ",
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
                                            " (+10% < ???????????? ?????? ??????(${indicator[widget.currentIndex]["result"][2]}%) <= +20% => ${indicator[widget.currentIndex]["indicator"][2]}???)",
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
                                            text: "???????????????",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                            children: [
                                          TextSpan(
                                            text: "(????????????(?????????) ?????? ??????)",
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
                                            "?????? ????????????:",
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
                                          BlockContainer(text: "??????-??????"),
                                          SizedBox(
                                            width: defaultPadding * 0.5,
                                          ),
                                          BlockContainer(text: "??????"),
                                          SizedBox(
                                            width: defaultPadding * 0.5,
                                          ),
                                          BlockContainer(text: "?????? ?????????"),
                                          SizedBox(
                                            width: defaultPadding * 0.5,
                                          ),
                                          BlockContainer(text: "?????? ??????"),
                                        ],
                                      ),
                                      SizedBox(
                                        height: defaultPadding * 2,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "?????? ???: ",
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
                                              " (0.4 <= ?????? ?????? ??????(${indicator[widget.currentIndex]["result"][3]}) < 0.5 => ${indicator[widget.currentIndex]["indicator"][3]}???)",
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
                                              text: "???????????????",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              children: [
                                            TextSpan(
                                              text: "(??????-?????? ?????? ?????????)",
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
                                                  return '30???';
                                                case 30:
                                                  return '1???';
                                                case 45:
                                                  return '1??? 30???';
                                                case 60:
                                                  return '2???';
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
                                      "????????? : ${indicator[widget.currentIndex]["indicator"][3]}???",
                                  tooltipMessage: "??????",
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
