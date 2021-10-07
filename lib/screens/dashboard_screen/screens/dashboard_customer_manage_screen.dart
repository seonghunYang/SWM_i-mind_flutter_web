import 'package:ai_counseling_platform/screens/dashboard_screen/components/profile_card.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/search_bar.dart';
import 'package:flutter/material.dart';

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
        child: DefaultTabController(
          initialIndex: 1,
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              titleSpacing: 20,
              elevation: 0,
              centerTitle: false,
              backgroundColor: Colors.white,
              actions: [
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
