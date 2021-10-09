import 'package:ai_counseling_platform/controllers/customer_controller.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/counseling_record_table.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/customer_table.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/facial_distribution.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/facial_info_card.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/multi_line_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/pie_odd_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/profile_card.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/search_bar.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/stats_radar_charts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class DashboardCustomerManageScreen extends StatelessWidget {
  const DashboardCustomerManageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffd1f8e4).withOpacity(0.3),
      padding: EdgeInsets.all(defaultPadding * 4),
      child: Card(
        elevation: 2,
        child: Consumer<CustomerController>(
            builder: (context, customerController, _) {
          if (customerController.isSelected) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: false,
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(40),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: defaultPadding * 1.5,
                        horizontal: defaultPadding * 3),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProfileInfoCell(
                            title: "보호자 성함",
                            info: "양희남",
                          ),
                          ProfileInfoCell(
                            title: "나이",
                            info: "45개월",
                          ),
                          ProfileInfoCell(
                            title: "성별",
                            info: "남아",
                          ),
                          ProfileInfoCell(
                            title: "상담횟수",
                            info: "4",
                          ),
                          ProfileInfoCell(
                            title: "이메일",
                            info: "didtjdgns852@gmail.com",
                          ),
                          ProfileInfoCell(
                            title: "특이사항",
                            info: "경미한 틱 증상을 보임",
                          ),
                        ]),
                  ),
                ),
                elevation: 1,
                titleSpacing: 20,
                leading: InkWell(
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    customerController.unSelectCustomer();
                  },
                ),
                title: Text(
                  "양성훈 상담자",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 20),
                ),
              ),
              body: Container(
                padding: EdgeInsets.all(defaultPadding * 1.5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Card(
                                    elevation: 4,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: defaultPadding * 4,
                                          top: defaultPadding),
                                      height: 300,
                                      child: Column(
                                        children: [
                                          Text(
                                            "상담 결과 변화량",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          SizedBox(
                                            height: defaultPadding * 2,
                                          ),
                                          Expanded(child: MultiLineChart()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Card(
                                    elevation: 4,
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: defaultPadding),
                                      height: 300,
                                      child: Column(
                                        children: [
                                          Text(
                                            "최근 상담지표",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          SizedBox(
                                            height: defaultPadding * 2,
                                          ),
                                          Expanded(child: StatsRadarChart()),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: defaultPadding,
                            ),
                            Expanded(
                              child: Card(
                                  elevation: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "상담 기록",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: defaultPadding * 2),
                                        CounselingRecordTable(),
                                      ],
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(defaultPadding),
                          child: FacialDistribution(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  titleSpacing: 20,
                  elevation: 0,
                  centerTitle: false,
                  backgroundColor: Colors.white,
                  actions: const [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProfileCard(isBorder: false),
                    )
                  ],
                  title: Text(
                    "고객 관리",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 20),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size(1000, 50),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 380,
                        child: TabBar(
                          unselectedLabelColor: Colors.grey,
                          labelColor: kSelectedDashboardTextColor,
                          indicatorColor: kSelectedDashboardTextColor,
                          tabs: <Widget>[
                            Tab(
                              child: Text(
                                "전체 고객",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "오늘 방문 고객",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "즐겨찾기",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                body: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: defaultPadding * 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 300,
                              height: 70,
                              padding: EdgeInsets.all(defaultPadding * 2),
                              child: SearchBar(),
                            ),
                            InkWell(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding,
                                    vertical: defaultPadding),
                                decoration: BoxDecoration(
                                    color: kSelectedDashboardTextColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: Row(children: [
                                  Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                  Text(
                                    "신규 고객 생성",
                                    style: TextStyle(fontSize: 13),
                                  )
                                ]),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(defaultPadding),
                          child: CustomerTable(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}

class ProfileInfoCell extends StatelessWidget {
  const ProfileInfoCell({
    Key? key,
    required this.title,
    required this.info,
  }) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title:",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.black.withOpacity(0.70),
                // fontWeight: FontWeight.bold,
              ),
        ),
        Text(" $info", style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
