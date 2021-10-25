import 'package:ai_counseling_platform/model/radarchart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/bottom_info_appbar.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/dashboard_bar_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/profile_info_cell.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/stats_radar_charts.dart';
import 'package:fl_chart/fl_chart.dart';
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
  bool visible = false;

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
          actions: [
            Icon(
              Icons.share,
              color: Colors.black54,
            ),
            SizedBox(
              width: defaultPadding * 3,
            ),
          ],
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
            child: Builder(builder: (context) {
              if (!visible) {
                Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    visible = true;
                  });
                });
                return SizedBox(
                  height: 600,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
              } else {
                return Column(
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
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CounselingReportCell(
                                    title: "인테이크 질문",
                                    text:
                                        '1. 출산이나 돌 이전에 발달이슈가 있었나요? : 아니오\n2. 출생- 돌전까지 주 양육자는 누구였나요? : 엄마\n3. 현재 기관에 다니고 있나요? : 유치원\n4. 현재 주 양육자는 누구인가요 (평일기준 아이를 가장 많이 담당하는 사람) : 엄마',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CounselingReportCell(
                      text:
                          '시우는 자신이 흥미로워하는 놀이를 적극적으로 엄마와 공유하고자 하였어요. 엄마에게 눈을 맞추고 놀이에 대해 나누며 엄마를 적극적으로 초대하였지요. 살얼음판게임을 하며 아슬아슬한 상황에서는 고개를 들어 엄마의 얼굴을 살피기도 하고, 겨울왕국 역할놀이를 시작하기 전에 피규어들을 보며 엄마에게 이야기를 건네기도 해요. 역할놀이를 하면서도 장난감의 역할을 설명하며 엄마와 놀이를 공유하고자 하였어요. 자신만의 세계에 머무는 것이 아니라 타인과 함께 자신의 놀이를 공유하고자 하는 이런 모습은, 사회성 발달에 있어 아주 중요한 자원이 되는 강점이랍니다. 항상 시우의 말과 눈맞춤에 반응할 수는 없지만, 가능한 집중하는 시간만큼이라도 아이의 이런 강점에 잘 반응해준다면 더욱 좋을 거예요.\n\n시우는 놀이 시간 내내 에너지가 높아 보였고 놀이에 대한 즐거움이 느껴졌어요. 특히 게임에서 이겼을 때는 외적으로 즐거운 감정을 크게 표현하였지요. 또한 역할놀이를 할 때도 자신이 표현이 하고 싶은 이야기를 말할 때 마다 목소리가 높아지며 흥분하고 신나는 모습이 나타났어요. 이렇게 즐겁게놀이를 할 수 있으면, 아이가 일상에서 느낀 스트레스를 해소할 수 있게 되고, 같은 10분이지만 부모와 보내는 시간에도 더욱 만족하게 되기에 매우 좋은 강점이랍니다.',
                      mainChartWidget: Container(
                        height: 250,
                        width: 550,
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "대표행동 지속시간 분석",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: defaultPadding * 2,
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
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
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
                      title: "아이 강점",
                    ),
                    SizedBox(
                      height: defaultPadding * 4,
                    ),
                    CounselingReportCell(
                      text:
                          '시우의 표정이나 대화를 잘 관찰해보면, 기본적으로 아이는 자신이 생각한 스토리와 놀이 계획을 가지고 있고 그것을 표현하고 싶어하는 아이었어요. 하지만 실제 놀이에서는 결국 엄마가 제시하는 방식대로 협조하며 따라주는 경우가 더 많았어요. 엄마가 겨울왕국 피규어를 배치하는 것을 가만히 지켜보며 그냥 수긍하고 따라가거나, 신나게 놀이를 하다가도 엄마가 "계산해야지, 인사하고" 라는 갑작스러운 제시에 협조하는 점, 사슴과 순록에 대한 질문에 하던 놀이를 멈추고 엄마에게 대답하는 점 등에서 이러한 모습을 엿볼 수 있었어요.\n\n시우가 워낙 적극적이고 명랑하다보니 그냥 아이가 잘 놀고 있구나 라고 느낄 수 있어요. 하지만  자세히 보면, 전체 놀이에서 아이의 놀이보다는 엄마가 끌고 가는 놀이의 비중이 훨씬 많아요. 아이가 먼저 시작했어도 결국 엄마가 주도하는 방식으로 가거나 엄마가 끝을 내버리는 상황이 자주 관찰되었어요. \n\n일상생활에서는 아이에게 훈육도 해야하고 어느 정도 규칙과 제한이 있을 수 있어요. 하지만 아이가 자유롭게 끌고 나가야할 자유놀이 시간에서마저, 아이가 주도할 수 있는 경험이 너무 없다면 아이는 부모와의 놀이에서 해소되지 못한 욕구를 또래에게 풀려고 하거나, 엄마가 없이 스스로 놀이하는 것은 어려워하고 자꾸만 누군가를 매어두려고 하는 놀이패턴을 보일 수 밖에 없어요. 아이에게 놀이는 주도성을 연습하고 스트레스를 해소하는 소중한 심리적 공간입니다. 일상생활에서 아이의 협력을 더 많이 얻어내고 싶다면, 놀이에서의 주도권을 아이가 좀 더 가져갈 수 있게 해주세요!',
                      mainChartWidget: Container(
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
                      title: "아이 보완점",
                    ),
                    SizedBox(
                      height: defaultPadding * 4,
                    ),
                    CounselingReportCell(
                        title: "부모 강점",
                        text:
                            '엄마는 시우가 하는 놀이를 가까이에서 바라봐주셨어요. 10분이라는 시간 동안 꾸준히 아이의 놀이를 따라가면서 함께하는 것은 사실 쉽지 않아요. 특히 아이의 놀이 흐름에 맞추어 피규어를 움직여가며 몸을 숙이기도 하시면서 시우와의 눈높이, 거리를 가까이 유지해 주신 부분 너무 좋아요. 아이와의 좋은 관계나 대화를 위한 전제는 우선 아이가 하는 것을 가까이에서 바라보는 것부터 시작되지요. 그러한 의미에서 시우와 앞으로 더 많은 놀이를 주고받을 수 있는 기본자세를 가지고 계신 것이라 여겨집니다.'),
                    SizedBox(
                      height: defaultPadding * 4,
                    ),
                    CounselingReportCell(
                        title: "부모 보완점",
                        text:
                            '영상을 보면 엄마가 게임에서 지자 시우는 "예~ 히히. 엄마가 졌어. 이번엔 내가 일등!" 하며 좋아하였어요. 하지만 이어지는 엄마의 반응은  "이제 우리 그만하고 한글쓰기 하자. 이거 맞춰 놔야지 이제." 라고 하며 갑자기 놀이를 종료시켜버렸어요. 시우는 아쉬운 듯 보였으나 다시 겨울왕국 피규어가 든 책을 가져와서 놀이를 제안하지요. 하지만 이번에도 엄마는 다시금 보드게임을 정리해야한다고 이야기하며 아이가 한참동안 책을 보여주며 설명을 하는 중에도 계속 정리하는 것에 몰두 했어요. 이렇게 정리하며 보낸 시간이 전체 놀이시간 중 1분 30초 이상을 차지 했답니다.\n\n시우의 목소리와 표정을 참고하자면, 아이는 게임이 즐거웠고 이긴 것에 대한 만족감도 컸어요. 하지만 놀이가 너무 빨리 마무리 되어버리자 이에 대한 아쉬움이 컸겠지요. 새로운 놀이를 제안했지만 엄마의 "정리제안" 으로 인해 놀이를 바로 시작하지 못하고 또 기다려야 했어요. 만약, 아이가 게임에서 이겼을 때 1) 함께 이긴 기쁨을 좀 더 느끼도록 머물러주거나 2) 이겨서 축하해! 라고 반응해주며 친구들과의 상호작용에서 적용할 수 있는 태도를 보여주거나 3) "한번 더 할래? 아니면 다른 놀이할까" 라고 아이에게 제안을 해주었다면 아이는 이 놀이 시간이 좀 더 즐겁고 의미 있었을 거에요. 같은 시간을 놀아도 만족감 또한 크지요. \n\n더불어, 하나의 놀이가 끝나고 바로바로 정리해야한다는 규칙을 부모가 중요하게 생각할 수는 있지만, 아이의 가정내에서 부모와의 놀이시간을 좀 더 효과적으로 사용하기 위해서는 시간내에서 여러 놀이를 충분히 하고, 놀이가 완전히 종료될 때 같이 치우는 것이 좋아요. 그래야 놀이의 흐름이 끊기지 않고, 이 놀이감과 저 놀이감이 연결되는 확장이 이루어지기 쉬우며, 놀이시간을 충분히 자신이 소유했기에 만족스럽게 종료할 수 있기 때문이에요. '),
                    SizedBox(
                      height: defaultPadding * 4,
                    ),
                    CounselingReportCell(
                        title: "총평",
                        text:
                            '시우의 눈을 바라보는 것이 중요해요. 엄마가 고개를 숙이고 자신의 활동(놀이)에 너무 집중하거나, 혹은 아이의 손을 중심으로 보게되면, 정작 아이의 관심이 지금 어디에 있는지 파악하기가 어려우며 아이와 눈맞춤을 할 수 있는 기회도 적어져요. 아이의 눈을 중심으로 보되 우연히 눈이 마주치게 된다면 긍정과 승인의 의미로 웃어주거나 고개를 가볍게 끄덕여주세요. 아이는 안도하고 안정감 있게 놀이를 지속해 나갈 수 있어요. 또한 시우의 눈이 머무는 곳에 대해 언어나 행동으로 반응하게 된다면, 반응 또한 아이의 흥미와 일치되어 더욱 긍정적이에요\n\n놀이에서는 시우가 더 많은 권한과 의사결정을 가져가야해요. 그래야 아이의 놀이가 즐거울 수 있고 아이가 놀이를 통해 스트레스를 해소하고, 무언가를 충분히 연습할 수 있거든요. 마치 아이가 감독이고 부모는 대본대로 하는 배우라고 생각해보세요. 놀이하는 시간 만큼은 규칙이나 방법을 때때로 벗어나 다양한 시도를 해보아도 좋고, 사람이 냉장고 안에 들어가거나 기차가 비행기처럼 날라가는 상상도 허용될 수 있어야 해요. 아이가 하는 놀이 방식에 기꺼이 참여해주세요. 시우가 원하는 것이 무엇인지 모르겠다면, "나는 어떤 역할을 하면되지?" "그 다음에 어떻게 할까?" 라고 살짝 물어보는 것도 좋아요.\n\n시우가 놀이하는 중에 "이건 뭐야?" 와 같이 질문이 많아지거나, "똑같은 모양은 어디 있지? / 우주선은 어떤거지?" 와 같이 가르치려는 시도가 많아지면 아이는 자신이 생각하고 느끼는 것을 놀이 안에서 표현하거나 자신의 의도대로 놀이를 진행할 수가 없어요. 영유아시기의 인지발달은 단순히 지식을 밀어넣어서가 아니라 아이가 자신의 흥미에 의해 먼저 시작하고 그것을 스스로 반복할 때 더 기억에 남으며 지식으로 확장될 수 있음을 기억해주세요!\n\n시우에게 칭찬과 격려를 많이 해준다고 생각하지만, 실제로는 놀이를 하고 있는 10분의 장면 안에서도 직접적인 칭찬이나 격려를 하는 경우가 많지 않아요. 그렇기 때문에 아이는 사실 격려와 칭찬을 받기보다는 통제와 제한을 받는 것이 훨씬 더 많답니다. 놀이에서 만큼이라도 분명하게 해낸 것과 잘 안되도 반복하여 노력하는 과정에 대한 직접적인 언어표현을 해주세요. 놀이 뿐 아니라 일상생활에 까지 아이와의 관계를 개선하고 협력을 얻어내는데 도움이 될 수 있어요.'),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}

class CounselingReportCell extends StatelessWidget {
  const CounselingReportCell({
    Key? key,
    required this.title,
    required this.text,
    this.mainChartWidget,
  }) : super(key: key);

  final String title;
  final Widget? mainChartWidget;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: defaultPadding * 2,
        ),
        Container(
          padding: mainChartWidget != null
              ? EdgeInsets.symmetric(
                  horizontal: defaultPadding * 2, vertical: defaultPadding * 5)
              : EdgeInsets.symmetric(
                  horizontal: defaultPadding * 2, vertical: defaultPadding * 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              color: Colors.black26,
            ),
          ),
          child: Column(
            children: [
              if (mainChartWidget != null) mainChartWidget!,
              if (mainChartWidget != null)
                SizedBox(
                  height: defaultPadding * 2,
                ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
