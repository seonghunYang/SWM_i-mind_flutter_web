import 'package:ai_counseling_platform/controllers/customer_controller.dart';
import 'package:ai_counseling_platform/controllers/user_controller.dart';
import 'package:ai_counseling_platform/model/radarchart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/bottom_info_appbar.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/counseling_record_table.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/customer_table.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/facial_distribution.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/facial_info_card.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/multi_line_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/pie_odd_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/profile_card.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/profile_info_cell.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/rounded_create_button.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/search_bar.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/stats_radar_charts.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/user_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../components/user_create_alert_dialog.dart';
import 'dashboard_customer_info_screen.dart';

class DashboardCustomerManageScreen extends StatelessWidget {
  const DashboardCustomerManageScreen({Key? key}) : super(key: key);

  Future<void> showUserCreateDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return UserCreateAlertDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffd1f8e4).withOpacity(0.3),
      padding: EdgeInsets.all(defaultPadding * 2),
      child: Card(
        elevation: 2,
        child: Consumer<CustomerController>(
            builder: (context, customerController, _) {
          if (customerController.isSelected) {
            return DashBoardCustomerInfoScreen(
                customerController: customerController);
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
                            RoundedCreateButton(
                              text: "신규 고객 생성",
                              onTap: () {
                                showUserCreateDialog(context);
                              },
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
