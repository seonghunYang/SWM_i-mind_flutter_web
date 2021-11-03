import 'dart:ui';

import 'package:ai_counseling_platform/controllers/counseling_record_controller.dart';
import 'package:ai_counseling_platform/controllers/menu_controller.dart';
import 'package:ai_counseling_platform/controllers/selected_counseling_record_controller.dart';
import 'package:ai_counseling_platform/model/conseling_record.dart';
import 'package:ai_counseling_platform/model/linechart_metadata.dart';
import 'package:ai_counseling_platform/model/linechart_rawdata.dart';
import 'package:ai_counseling_platform/model/radarchart_rawdata.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/progress_card.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/block_container.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/bottom_info_appbar.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/counseling_report_dialog.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/dashboard_bar_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/line_area_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/processed_video.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/profile_info_cell.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/stat_analysis_card.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/stats_radar_charts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../constants.dart';

const Map<String?, String> wordDic = {
  "stand": "서기",
  "touch sth.": "접촉하기",
  "carry/hold sth.": "물체 잡기",
  "listen to sb.": "듣기",
  "sit": "앉기",
  "HAPPY": "행복",
  "CALM": "중립",
  "ANGRY": "분노",
  "talk": "말하기",
};

const List<Map> indicator = [
  {
    "indicator": [8, 8, 4, 8, 7],
    "result": [48, 139, 18.6, 0.27],
    "action": [23, 22, 55]
  },
  {
    "indicator": [10, 8, 6, 6, 8],
    "result": [55, 139, 18.6, 0.27],
    "action": [30, 33, 37]
  },
];

class DashboardCounselingRecordManageScreen extends StatefulWidget {
  const DashboardCounselingRecordManageScreen({Key? key}) : super(key: key);

  @override
  State<DashboardCounselingRecordManageScreen> createState() =>
      _DashboardCounselingRecordManageScreenState();
}

class _DashboardCounselingRecordManageScreenState
    extends State<DashboardCounselingRecordManageScreen> {
  final ScrollController _scrollController = ScrollController();
  late VideoPlayerController _videoPlayerController;
  bool isLoading = true;
  bool isReadyVideoPlay = false;
  int videoSeconds = 0;
  var data;

  @override
  void initState() {
    // _tabController = TabController(length: 2, vsync: this);
    super.initState();
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

  void initVideoController(String url) {
    _videoPlayerController = VideoPlayerController.network(
      url,
    )..initialize().then((_) {
        setState(() {
          isReadyVideoPlay = true;
          videoSeconds = _videoPlayerController.value.duration.inSeconds;
        });
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
    CounselingRecordController counselingRecordController =
        context.watch<CounselingRecordController>();
    CounselingRecord? selectedCounselingRecord =
        counselingRecordController.selectedCounselingRecord;
    int currentIndex = counselingRecordController.counselingIndex;

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
              counselingRecordController.updateCounselingIndex();
              context.read<MenuController>().updateMenuIndex(1);
            },
            title: "AI 분석리포트",
            infoList: [
              ProfileInfoCell(
                title: "상담 번호",
                info: selectedCounselingRecord!.counselingId,
              ),
              ProfileInfoCell(
                title: "자녀 이름",
                info: selectedCounselingRecord.childName,
              ),
              ProfileInfoCell(
                title: "상담종류",
                info: selectedCounselingRecord.category,
              ),
              ProfileInfoCell(
                title: "상담날짜",
                info: selectedCounselingRecord.date,
              ),
            ],
          ),
          body: Builder(builder: (context) {
            if (isLoading) {
              context
                  .read<SelectedCounselingRecordController>()
                  .getCounselingDetail(counselingRecordController
                      .selectedCounselingRecord!.realId)
                  .then((value) {
                setState(() {
                  data = value;
                  isLoading = false;
                });
              });
              print("a");
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
            var emotionAll = data["emotionAll"];
            var actionList = data["actionList"];
            var emotionChild = data["emotionChild"];
            var actionTime = data["actionTime"];
            var talkPercentage = data["talkPercentage"];

            return Builder(builder: (context) {
              if (!isReadyVideoPlay) {
                initVideoController(data["videoUrl"]);
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                controller: _scrollController,
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Card(
                                  child: Container(
                                    child: ProcessedVideo(
                                      videoPlayerController:
                                          _videoPlayerController,
                                      onTap: playingVideo,
                                    ),
                                  ),
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                          SizedBox(
                                            width: defaultPadding,
                                          ),
                                          Tooltip(
                                            message: "ㅁㄴㅇ",
                                            decoration: BoxDecoration(
                                                color: Colors.black87),
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
                                                    color:
                                                        kSelectedDashboardTextColor,
                                                    text: "분석 점수",
                                                    isSquare: false,
                                                    size: 12,
                                                  ),
                                                  ChartIndicator(
                                                    color:
                                                        kSelectedContainerColor,
                                                    text: "또래 점수평균",
                                                    isSquare: false,
                                                    size: 12,
                                                  ),
                                                ],
                                                rawDatasets: [
                                                  RadarChartRawDataSet(
                                                    title: 'mean',
                                                    color:
                                                        kSelectedContainerColor,
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
                                                    color:
                                                        kSelectedDashboardTextColor,
                                                    values: [
                                                      indicator[currentIndex]
                                                          ["indicator"][0],
                                                      indicator[currentIndex]
                                                          ["indicator"][1],
                                                      indicator[currentIndex]
                                                          ["indicator"][2],
                                                      indicator[currentIndex]
                                                          ["indicator"][3],
                                                      indicator[currentIndex]
                                                          ["indicator"][4],
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        defaultPadding * 3),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ScoreCard(
                                                      title: "즐거움",
                                                      score: indicator[
                                                              currentIndex]
                                                          ["indicator"][0],
                                                    ),
                                                    ScoreCard(
                                                      title: "지속성/몰입도",
                                                      score: indicator[
                                                              currentIndex]
                                                          ["indicator"][1],
                                                    ),
                                                    ScoreCard(
                                                      title: "주도성",
                                                      score: indicator[
                                                              currentIndex]
                                                          ["indicator"][2],
                                                    ),
                                                    ScoreCard(
                                                      title: "밀착도",
                                                      score: indicator[
                                                              currentIndex]
                                                          ["indicator"][3],
                                                    ),
                                                    ScoreCard(
                                                      title: "반복하기",
                                                      score: indicator[
                                                              currentIndex]
                                                          ["indicator"][4],
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Card(
                            elevation: 0.5,
                            margin: EdgeInsets.zero,
                            child: Container(
                              width: 300,
                              height: 50,
                              child: TabBar(
                                unselectedLabelColor: Colors.grey,
                                labelColor: kSelectedDashboardTextColor,
                                indicatorColor: kSelectedDashboardTextColor,
                                tabs: [
                                  Text(
                                    '영상 메타데이터',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    '지표분석 결과',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
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
                            child: TabBarView(children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: defaultPadding * 2,
                                  ),
                                  StatAnalysisCard(
                                    singleSubContentFlex: 1,
                                    singleMainContentFlex: 5,
                                    tooltipMessage: "감정별 신뢰도의 변화량",
                                    title: "부모-아이 감정 분석",
                                    hintMessageList: [
                                      "- 감정수치가 0.8 이상인 장면은 부모-아이 관계가 두드러지는 장면일 수 있습니다.",
                                      "- 특정 감정의 부모-아이간 편차는 놀이에 대한 태도를 유추할 수 있습니다."
                                    ],
                                    videoSeconds: videoSeconds,
                                    videoPlayerController:
                                        _videoPlayerController,
                                    pointVideoDuration: pointVideoDuration,
                                    singleMainContent: Column(
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
                                                    color: colorList[0],
                                                    text: "부모",
                                                    isSquare: true),
                                                SizedBox(
                                                  width: defaultPadding,
                                                ),
                                                ChartIndicator(
                                                    color: colorList[1],
                                                    text: "아이",
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
                                            onTap: pointVideoDuration,
                                            lineChartMetaData:
                                                LineChartMetaData(
                                              minX: 0,
                                              maxX: _videoPlayerController
                                                  .value.duration.inSeconds
                                                  .toDouble(),
                                              minY: 0,
                                              maxY: 100,
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
                                                color: colorList[0],
                                                values:
                                                    emotionAll["parentEmotion"],
                                              ),
                                              LineChartRawDataSet(
                                                title: "--",
                                                color: colorList[1],
                                                values:
                                                    emotionAll["childEmotion"],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    singleSubContent: Container(),
                                    // singleSubContent: Padding(
                                    //   padding: EdgeInsets.symmetric(
                                    //       horizontal: defaultPadding * 2),
                                    //   child: Column(
                                    //     children: [
                                    //       // Row(
                                    //       //   children: [
                                    //       //     Text("분석 신뢰도: ",
                                    //       //         style: Theme.of(context).textTheme.bodyText1),
                                    //       //     Text("90%",
                                    //       //         style: Theme.of(context).textTheme.bodyText1),
                                    //       //   ],
                                    //       // ),
                                    //       Column(
                                    //         children: [
                                    //           Text("부모-아이 감정 비율",
                                    //               style: Theme.of(context)
                                    //                   .textTheme
                                    //                   .bodyText1),
                                    //           SizedBox(
                                    //             height: defaultPadding * 1.5,
                                    //           ),
                                    //           Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .spaceBetween,
                                    //             children: [
                                    //               Text(
                                    //                 "부모",
                                    //                 style: Theme.of(context)
                                    //                     .textTheme
                                    //                     .bodyText1!
                                    //                     .copyWith(fontSize: 12),
                                    //               ),
                                    //               Text(
                                    //                 "아이",
                                    //                 style: Theme.of(context)
                                    //                     .textTheme
                                    //                     .bodyText1!
                                    //                     .copyWith(fontSize: 12),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //           SizedBox(
                                    //             height: defaultPadding * 0.5,
                                    //           ),
                                    //           ProgressLine(
                                    //             color: kSelectedContainerColor,
                                    //             percentage: 30,
                                    //           ),
                                    //           SizedBox(
                                    //             height: defaultPadding * 0.5,
                                    //           ),
                                    //           Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .spaceBetween,
                                    //             children: [
                                    //               Text(
                                    //                 "30%",
                                    //                 style: Theme.of(context)
                                    //                     .textTheme
                                    //                     .bodyText1!
                                    //                     .copyWith(
                                    //                         fontSize: 11,
                                    //                         color: Colors.grey),
                                    //               ),
                                    //               Text(
                                    //                 "70%",
                                    //                 style: Theme.of(context)
                                    //                     .textTheme
                                    //                     .bodyText1!
                                    //                     .copyWith(
                                    //                         fontSize: 11,
                                    //                         color: Colors.grey),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),
                                  ),
                                  SizedBox(
                                    height: defaultPadding * 2,
                                  ),
                                  StatAnalysisCard(
                                    singleMainContentFlex: 3,
                                    singleSubContentFlex: 1,
                                    videoSeconds: videoSeconds,
                                    videoPlayerController:
                                        _videoPlayerController,
                                    pointVideoDuration: pointVideoDuration,
                                    title: "아이 대표헹동 분석",
                                    tooltipMessage: "ㅁㅁ",
                                    singleSubContent: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 220,
                                          height: 240,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "대표행동 비율(%)",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
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
                                                    [
                                                      0,
                                                      indicator[currentIndex]
                                                          ["action"][0]
                                                    ],
                                                    [
                                                      1,
                                                      indicator[currentIndex]
                                                          ["action"][1]
                                                    ],
                                                    [
                                                      2,
                                                      indicator[currentIndex]
                                                          ["action"][2]
                                                    ],
                                                  ],
                                                  maxY: 120,
                                                  getLeftTitle: (value) {
                                                    switch (value.toInt()) {
                                                      case 25:
                                                        return '25';
                                                      case 50:
                                                        return '50';
                                                      case 75:
                                                        return '75';
                                                      case 100:
                                                        return '100';
                                                    }
                                                    return '';
                                                  },
                                                  getBottomTitle:
                                                      (double value) {
                                                    switch (value.toInt()) {
                                                      case 0:
                                                        return '듣기';
                                                      case 1:
                                                        return '말하기';
                                                      case 2:
                                                        return '물체 잡기';
                                                      default:
                                                        return '';
                                                    }
                                                  },
                                                  getTooltipItem: (group,
                                                      groupIndex,
                                                      rod,
                                                      rodIndex) {
                                                    String profile;
                                                    switch (group.x.toInt()) {
                                                      case 0:
                                                        profile = '듣기';
                                                        break;
                                                      case 1:
                                                        profile = '말하기';
                                                        break;
                                                      case 2:
                                                        profile = '물체 잡기';
                                                        break;
                                                      default:
                                                        throw Error();
                                                    }
                                                    return BarTooltipItem(
                                                      profile + '\n',
                                                      TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: "${rod.y}%",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff3FC37C),
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
                                    hintMessageList: [
                                      "- 대표행동의 반복 패턴과 비율을 통해 아이의 성향을 파악할 수 있습니다. ",
                                      "* 대표행동: 사전에 선정한 대표행동이 없는경우 영상 내에서 가장 많은 빈도를 보이는 행동을 보여줍니다."
                                    ],
                                    singleMainContent: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "대표행동 시간대별 분포도",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            Row(
                                              children: List.generate(
                                                  actionList["actionCategory"]
                                                      .length,
                                                  (index) => Row(
                                                        children: [
                                                          ChartIndicator(
                                                              color: colorList[
                                                                  index],
                                                              text: wordDic[actionList[
                                                                          "actionCategory"]
                                                                      [
                                                                      index]] ??
                                                                  actionList[
                                                                          "actionCategory"]
                                                                      [index],
                                                              isSquare: true),
                                                          SizedBox(
                                                            width:
                                                                defaultPadding,
                                                          ),
                                                        ],
                                                      )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: defaultPadding * 2,
                                        ),
                                        Container(
                                          height: 200,
                                          child: LineAreaChart(
                                            onTap: pointVideoDuration,
                                            lineChartMetaData:
                                                LineChartMetaData(
                                              minX: 0,
                                              maxX: _videoPlayerController
                                                  .value.duration.inSeconds
                                                  .toDouble(),
                                              minY: 0,
                                              maxY: 100,
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
                                            lineChartRawDataSets: List.generate(
                                                actionList["dataList"].length,
                                                (index) => LineChartRawDataSet(
                                                      title: "--",
                                                      color: colorList[index],
                                                      values:
                                                          actionList["dataList"]
                                                              [index],
                                                    )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                                          tooltipMessage: indicatorHappyMessage,
                                          title:
                                              "즐거움 : ${indicator[currentIndex]["indicator"][0]}점",
                                          // hintMessageList: [
                                          //   "- 행복 감정의 변화는 아이의 놀이에 대한 흥미를 확인할 수 있습니다.",
                                          //   "- 대표행동의 최장 지속시간은 아이의 놀이 지속성/몰입도를 유추해낼 수 있습니다."
                                          // ],
                                          videoSeconds: videoSeconds,
                                          videoPlayerController:
                                              _videoPlayerController,
                                          pointVideoDuration:
                                              pointVideoDuration,
                                          singleSubContent: Container(),
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
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  SizedBox(
                                                    width: defaultPadding,
                                                  ),
                                                  BlockContainer(text: "아이"),
                                                  SizedBox(
                                                    width: defaultPadding * 0.5,
                                                  ),
                                                  BlockContainer(
                                                      text: "대표감정(행복)"),
                                                  SizedBox(
                                                    width: defaultPadding * 0.5,
                                                  ),
                                                  BlockContainer(
                                                      text: "비율 구하기"),
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
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                      "${indicator[currentIndex]["result"][0]}%",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1),
                                                  Text(
                                                      " (40% < 대표감정비율(${indicator[currentIndex]["result"][0]}%) <= 50% => ${indicator[currentIndex]["indicator"][0]}점)",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              ),
                                              SizedBox(
                                                height: defaultPadding * 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RichText(
                                                      text: TextSpan(
                                                          text: "해석그래프",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          children: [
                                                        TextSpan(
                                                          text:
                                                              "(아이 감정 시간대별 분포도)",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                        ),
                                                      ])),
                                                  Row(
                                                    children: List.generate(
                                                        emotionChild[
                                                                "emotionCategory"]
                                                            .length,
                                                        (index) => Row(
                                                              children: [
                                                                ChartIndicator(
                                                                    color: colorList[
                                                                        index],
                                                                    text: wordDic[emotionChild["emotionCategory"]
                                                                            [
                                                                            index]] ??
                                                                        emotionChild["emotionCategory"]
                                                                            [
                                                                            index],
                                                                    isSquare:
                                                                        true),
                                                                SizedBox(
                                                                  width:
                                                                      defaultPadding,
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
                                                  lineChartMetaData:
                                                      LineChartMetaData(
                                                    minX: 0,
                                                    maxX: _videoPlayerController
                                                        .value
                                                        .duration
                                                        .inSeconds
                                                        .toDouble(),
                                                    minY: 0,
                                                    maxY: 100,
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
                                                  lineChartRawDataSets:
                                                      List.generate(
                                                    emotionChild["dataList"]
                                                        .length,
                                                    (index) =>
                                                        LineChartRawDataSet(
                                                      title: "--",
                                                      color: colorList[index],
                                                      values: emotionChild[
                                                          "dataList"][index],
                                                    ),
                                                  ),
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
                                          tooltipMessage:
                                              indicatorConsistenceMessage,
                                          title:
                                              "지속성/몰입도 : ${indicator[currentIndex]["indicator"][1]}점",
                                          videoSeconds: videoSeconds,
                                          videoPlayerController:
                                              _videoPlayerController,
                                          pointVideoDuration:
                                              pointVideoDuration,
                                          singleSubContent: Container(),
                                          singleMainContent: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "설정 분석로직:",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        SizedBox(
                                                          width: defaultPadding,
                                                        ),
                                                        BlockContainer(
                                                            text: "아이"),
                                                        SizedBox(
                                                          width:
                                                              defaultPadding *
                                                                  0.5,
                                                        ),
                                                        BlockContainer(
                                                            text:
                                                                "대표행동(말하기, 잡기, 듣기)"),
                                                        SizedBox(
                                                          width:
                                                              defaultPadding *
                                                                  0.5,
                                                        ),
                                                        BlockContainer(
                                                            text: "지속시간 구하기"),
                                                        SizedBox(
                                                          width:
                                                              defaultPadding *
                                                                  0.5,
                                                        ),
                                                        BlockContainer(
                                                            text: "최대값 비교"),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          defaultPadding * 0.5,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          defaultPadding * 2,
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "분석 값: ",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        Text("154초",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1),
                                                        Text(
                                                            " (150초 < 대표행동 지속시간(${actionTime["time"] + 1}초) <= 180초 => ${indicator[currentIndex]["indicator"][1]}점)",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          defaultPadding * 3,
                                                    ),
                                                    RichText(
                                                        text: TextSpan(
                                                            text: "해석그래프",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                            children: [
                                                          TextSpan(
                                                            text:
                                                                "(대표행동 지속시간 비교)",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1,
                                                          ),
                                                        ])),
                                                    SizedBox(
                                                      height:
                                                          defaultPadding * 3,
                                                    ),
                                                    Container(
                                                      height: 200,
                                                      child: DashboardBarChart(
                                                        gridData: FlGridData(
                                                            show: true,
                                                            drawHorizontalLine:
                                                                true,
                                                            drawVerticalLine:
                                                                false),
                                                        barDataList: [
                                                          [
                                                            0,
                                                            actionTime["time"]
                                                          ],
                                                          [
                                                            1,
                                                            93,
                                                          ],
                                                        ],
                                                        maxY: 220,
                                                        getLeftTitle: (value) {
                                                          switch (
                                                              value.toInt()) {
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
                                                        getBottomTitle:
                                                            (double value) {
                                                          switch (
                                                              value.toInt()) {
                                                            case 0:
                                                              return '아이';
                                                            case 1:
                                                              return '센터평균';

                                                            default:
                                                              return '';
                                                          }
                                                        },
                                                        getTooltipItem: (group,
                                                            groupIndex,
                                                            rod,
                                                            rodIndex) {
                                                          String profile;
                                                          switch (
                                                              group.x.toInt()) {
                                                            case 0:
                                                              profile = '아이';
                                                              break;
                                                            case 1:
                                                              profile = '센터평균';
                                                              break;
                                                            default:
                                                              throw Error();
                                                          }
                                                          int minute =
                                                              rod.y ~/ 60;
                                                          int seconds =
                                                              rod.y.toInt() %
                                                                  60;
                                                          return BarTooltipItem(
                                                            profile + '\n',
                                                            TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                text:
                                                                    "$minute분 $seconds초",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff3FC37C),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                          videoPlayerController:
                                              _videoPlayerController,
                                          pointVideoDuration:
                                              pointVideoDuration,
                                          title:
                                              "주도성 : ${indicator[currentIndex]["indicator"][2]}점",
                                          tooltipMessage:
                                              indicatorLeadingMessage,
                                          // hintMessageList: [
                                          //   "- 발화의 비율을 통해 놀이에서 주도성을 파악할 수 있습니다.",
                                          //   "- 부모와 아이의 거리 편차를 이용하여 부모-아이 관계를 유추할 수 있습니다."
                                          // ],
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
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  SizedBox(
                                                    width: defaultPadding,
                                                  ),
                                                  BlockContainer(text: "아이-부모"),
                                                  SizedBox(
                                                    width: defaultPadding * 0.5,
                                                  ),
                                                  BlockContainer(
                                                      text: "대표행동(말하기)"),
                                                  SizedBox(
                                                    width: defaultPadding * 0.5,
                                                  ),
                                                  BlockContainer(
                                                      text: "비율 구하기"),
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
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                      "${indicator[currentIndex]["indicator"][2]}%",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1),
                                                  Text(
                                                      " (-5% < 대표행동 차이 비교(${talkPercentage['child']}%) <= +5% => ${indicator[currentIndex]["indicator"][2]}점)",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey))
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
                                                                  FontWeight
                                                                      .bold),
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "설정 분석로직:",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    SizedBox(
                                                      width: defaultPadding,
                                                    ),
                                                    BlockContainer(
                                                        text: "아이-부모"),
                                                    SizedBox(
                                                      width:
                                                          defaultPadding * 0.5,
                                                    ),
                                                    BlockContainer(text: "위치"),
                                                    SizedBox(
                                                      width:
                                                          defaultPadding * 0.5,
                                                    ),
                                                    BlockContainer(
                                                        text: "거리 구하기"),
                                                    SizedBox(
                                                      width:
                                                          defaultPadding * 0.5,
                                                    ),
                                                    BlockContainer(
                                                        text: "평균 비교"),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: defaultPadding * 2,
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "분석 값: ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Text(
                                                        "${indicator[currentIndex]["result"][3]}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1),
                                                    Text(
                                                        " (0.25 <= 평균 거리 비교(${indicator[currentIndex]["result"][3]}) < 0.3 => ${indicator[currentIndex]["indicator"][3]}점)",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey))
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
                                                                    FontWeight
                                                                        .bold),
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
                                                    lineChartMetaData:
                                                        LineChartMetaData(
                                                      minX: 0,
                                                      maxX: videoSeconds
                                                          .toDouble(),
                                                      minY: 0,
                                                      maxY: 100,
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
                                                          case 180:
                                                            return '3분';
                                                          case 240:
                                                            return '4분';
                                                          case 300:
                                                            return '5분';
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
                                                          [0, 20],
                                                          [10, 20],
                                                          [15, 22],
                                                          [20, 23],
                                                          [30, 27],
                                                          [35, 30],
                                                          [40, 28],
                                                          [50, 26],
                                                          [55, 24],
                                                          [60, 25],
                                                          [65, 26],
                                                          [70, 24],
                                                          [80, 27],
                                                          [85, 26],
                                                          [90, 26],
                                                          [100, 28],
                                                          [105, 27],
                                                          [110, 25],
                                                          [115, 27],
                                                          [120, 25],
                                                          [125, 27],
                                                          [130, 27],
                                                          [140, 27],
                                                          [145, 27],
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
                                            videoPlayerController:
                                                _videoPlayerController,
                                            pointVideoDuration:
                                                pointVideoDuration,
                                            title:
                                                "밀착도 : ${indicator[currentIndex]["indicator"][3]}점",
                                            tooltipMessage:
                                                indicatorTouchMessage,
                                            singleSubContent: Container(),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          }),
        ),
      ),
    );
  }
}

class PercentBar extends StatelessWidget {
  const PercentBar({
    Key? key,
    this.childPercentage = 25.3,
  }) : super(key: key);

  final double childPercentage;

  @override
  Widget build(BuildContext context) {
    double parentPercentage = 100 - childPercentage;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "부모",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "아이",
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
        SizedBox(
          height: defaultPadding * 0.5,
        ),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "$childPercentage%",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: kSelectedDashboardTextColor.withOpacity(0.7),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) => Container(
                alignment: Alignment.centerLeft,
                width: constraints.maxWidth * (parentPercentage / 100),
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      "$parentPercentage%",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: kSelectedContainerColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Container(
        //   child: Row(
        //     mainAxisAlignment:
        //         MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         "63.7",
        //         style:
        //             Theme.of(context).textTheme.bodyText1,
        //       ),
        //       Text(
        //         "26.3",
        //         style:
        //             Theme.of(context).textTheme.bodyText1,
        //       )
        //     ],
        //   ),
        // ),
      ],
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
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text("$score", style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
