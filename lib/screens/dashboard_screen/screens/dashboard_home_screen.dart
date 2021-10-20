import 'package:ai_counseling_platform/model/linechart_metadata.dart';
import 'package:ai_counseling_platform/model/linechart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/customer_table.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/dashboard_bar_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/line_area_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/number_data_card.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/profile_card.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/schedule_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({Key? key}) : super(key: key);

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: defaultPadding * 2.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: defaultPadding * 5,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Dashboard",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      Row(
                        children: const [
                          Expanded(
                            flex: 1,
                            child: NumberDataCard(
                              title: "상담한 고객수",
                              number: "302",
                              icon: Icon(
                                Icons.people_outline,
                                color: Colors.white,
                                size: 26,
                              ),
                              colors: [
                                Color(0xff3ABE76),
                                Color(0xff53E193),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: defaultPadding * 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: NumberDataCard(
                              title: "이번달 예약수",
                              number: "26",
                              icon: Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.white,
                                size: 26,
                              ),
                              colors: [
                                Color(0xffE8B83D),
                                Color(0xffFCD163),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: defaultPadding * 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: NumberDataCard(
                              title: "오늘 예약수",
                              number: "3",
                              icon: Icon(
                                Icons.pending_actions,
                                color: Colors.white,
                                size: 26,
                              ),
                              colors: [
                                Color(0xff667AC9),
                                Color(0xffA1B0EA),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: defaultPadding * 2,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 400,
                              child: Card(
                                elevation: 8,
                                shadowColor: Colors.black38,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(defaultPadding * 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "신규 고객 추이",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: LineAreaChart(
                                          onTap: (value) {},
                                          lineChartMetaData: LineChartMetaData(
                                            minX: 0,
                                            maxX: 20,
                                            minY: 0,
                                            maxY: 6,
                                            leftTitle: (value) {
                                              switch (value.toInt()) {
                                                case 1:
                                                  return '20';
                                                case 2:
                                                  return '40';
                                                case 3:
                                                  return '60';
                                                case 4:
                                                  return '80';
                                                case 5:
                                                  return '100';
                                              }
                                              return '';
                                            },
                                            bottomTitle: (value) {
                                              switch (value.toInt()) {
                                                case 2:
                                                  return 'JAN';
                                                case 6:
                                                  return 'MAR';
                                                case 10:
                                                  return 'JUN';
                                                case 14:
                                                  return 'SEP';
                                                case 18:
                                                  return 'NOV';
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
                                                  [1, 1.8],
                                                  [2, 2],
                                                  [3, 2.1],
                                                  [4, 2.2],
                                                  [5, 3.5],
                                                  [6, 4.4],
                                                  [7, 4.6],
                                                  [8, 3.9],
                                                  [9, 3.8],
                                                  [10, 4.4],
                                                  [11, 3.5],
                                                  [12, 2.9],
                                                  [13, 3.25],
                                                  [14, 3.8],
                                                  [15, 3.9],
                                                  [16, 4.1],
                                                  [17, 4.2],
                                                  [18, 4.5],
                                                  [19, 3.9],
                                                  [20, 3.8],
                                                ])
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: defaultPadding * 2,
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 400,
                              child: Card(
                                elevation: 8,
                                shadowColor: Colors.black38,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(defaultPadding * 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "신규 고객 추이",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: DashboardBarChart(
                                          gridData: FlGridData(show: false),
                                          barDataList: [
                                            [0, 5],
                                            [1, 6],
                                            [2, 13],
                                            [3, 8],
                                            [4, 9],
                                            [5, 12],
                                            [6, 7]
                                          ],
                                          maxY: 20,
                                          getLeftTitle: (value) {
                                            switch (value.toInt()) {
                                              case 2:
                                                return '2';
                                              case 5:
                                                return '5';
                                              case 8:
                                                return '8';
                                              case 11:
                                                return '11';
                                              case 14:
                                                return '14';
                                            }
                                            return '';
                                          },
                                          getBottomTitle: (double value) {
                                            switch (value.toInt()) {
                                              case 0:
                                                return 'M';
                                              case 1:
                                                return 'T';
                                              case 2:
                                                return 'W';
                                              case 3:
                                                return 'T';
                                              case 4:
                                                return 'F';
                                              case 5:
                                                return 'S';
                                              case 6:
                                                return 'S';
                                              default:
                                                return '';
                                            }
                                          },
                                          getTooltipItem: (group, groupIndex,
                                              rod, rodIndex) {
                                            String weekDay;
                                            switch (group.x.toInt()) {
                                              case 0:
                                                weekDay = 'Monday';
                                                break;
                                              case 1:
                                                weekDay = 'Tuesday';
                                                break;
                                              case 2:
                                                weekDay = 'Wednesday';
                                                break;
                                              case 3:
                                                weekDay = 'Thursday';
                                                break;
                                              case 4:
                                                weekDay = 'Friday';
                                                break;
                                              case 5:
                                                weekDay = 'Saturday';
                                                break;
                                              case 6:
                                                weekDay = 'Sunday';
                                                break;
                                              default:
                                                throw Error();
                                            }
                                            return BarTooltipItem(
                                              weekDay + '\n',
                                              TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: (rod.y - 1).toString(),
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
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: defaultPadding * 2,
                      ),
                      Container(
                        height: 500,
                        width: double.infinity,
                        child: Card(
                          elevation: 8,
                          shadowColor: Colors.black38,
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "고객 관리",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: defaultPadding * 2,
                                ),
                                Expanded(
                                  child: CustomerTable(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 1000,
                  decoration: BoxDecoration(
                      color: kDashboardMenuColor,
                      border: Border(
                          left: BorderSide(color: Colors.grey, width: 0.3))),
                  child: Column(
                    children: [
                      ProfileCard(isBorder: true),
                      Container(
                        padding: EdgeInsets.all(defaultPadding * 1.5),
                        child: ScheduleCalendar(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
