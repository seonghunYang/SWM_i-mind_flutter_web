import 'dart:html';

import 'package:ai_counseling_platform/controllers/counseling_record_controller.dart';
import 'package:ai_counseling_platform/controllers/customer_controller.dart';
import 'package:ai_counseling_platform/controllers/selected_customer_controller.dart';
import 'package:ai_counseling_platform/model/conseling_record.dart';
import 'package:ai_counseling_platform/model/customer.dart';
import 'package:ai_counseling_platform/model/customer_detail.dart';
import 'package:ai_counseling_platform/model/radarchart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/bottom_info_appbar.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/counseling_record_table.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/create_couinseling_record_dialog.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/facial_distribution.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/multi_line_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/profile_info_cell.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/rounded_create_button.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/stats_radar_charts.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/user_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/src/provider.dart';
import '../../../constants.dart';

class DashBoardCustomerInfoScreen extends StatelessWidget {
  const DashBoardCustomerInfoScreen({
    Key? key,
    required this.customerController,
  }) : super(key: key);

  final CustomerController customerController;

  Future<void> showUserCreateDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return CounselingRecordCreateAlertDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    Customer? selectedCustomer = customerController.selectedCustomer;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BottomInfoAppBar(
        onTap: () {
          customerController.unSelectCustomer();
        },
        title: selectedCustomer.childName,
        infoList: [
          ProfileInfoCell(
            title: "부모 이름",
            info: selectedCustomer.parentName,
          ),
          ProfileInfoCell(
            title: "부모 나이",
            info: "${selectedCustomer.parentAge}세",
          ),
          ProfileInfoCell(
            title: "아이 나이",
            info: "${selectedCustomer.childAge}개월",
          ),
          ProfileInfoCell(
            title: "성별",
            info: selectedCustomer.childGender,
          ),
          ProfileInfoCell(
            title: "이메일",
            info: selectedCustomer.email,
          ),
          ProfileInfoCell(
            title: "특이사항",
            info: selectedCustomer.special,
          ),
        ],
      ),
      body: FutureBuilder(
          future: context
              .watch<SelectedCustomerController>()
              .getCustomerDetail(selectedCustomer.id),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {}
            if (!snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else {
              var data = snapshot.data;
              // print(data["avgIndicator"]["responsiveness"]);
              // print(data["avgIndicator"]["responsiveness"].runtimeType);
              context
                  .read<CounselingRecordController>()
                  .setCounselingRecordList(
                      data["counselingRecordList"], selectedCustomer.childName);
              return Container(
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
                                          Expanded(
                                              child: MultiLineChart(
                                            lineChartBarDataSpotList: [
                                              data["indicatorRecordList"]
                                                  ["responsiveness"],
                                              data["indicatorRecordList"]
                                                  ["persistence"],
                                              data["indicatorRecordList"]
                                                  ["scrupulosity"],
                                            ],
                                            lineChartBarColorList: [
                                              Color(0xff4af699),
                                              Color(0xffaa4cfc),
                                              Color(0xff27b6fc)
                                            ],
                                            getBottomTitle: (value) {
                                              return data["date"]
                                                  [value.toInt()];
                                            },
                                          )),
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
                                          Expanded(
                                              child: StatsRadarChart(
                                            indicators: [
                                              ChartIndicator(
                                                color:
                                                    kSelectedDashboardTextColor,
                                                text: "최근 상담",
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
                                                  data["avgIndicator"][0],
                                                  data["avgIndicator"][1],
                                                  data["avgIndicator"][2],
                                                  data["avgIndicator"][3],
                                                  data["avgIndicator"][4],
                                                ],
                                              ),
                                              RadarChartRawDataSet(
                                                title: 'recent',
                                                color:
                                                    kSelectedDashboardTextColor,
                                                values: [
                                                  data["recentIndicator"]
                                                      ["responsiveness"],
                                                  data["recentIndicator"]
                                                      ["persistence"],
                                                  data["recentIndicator"]
                                                      ["scrupulosity"],
                                                  data["recentIndicator"]
                                                      ["point1"],
                                                  data["recentIndicator"]
                                                      ["point2"],
                                                ],
                                              ),
                                            ],
                                          )),
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "상담 기록",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            RoundedCreateButton(
                                                onTap: () {
                                                  showUserCreateDialog(context);
                                                },
                                                text: "상담 기록 추가")
                                          ],
                                        ),
                                        SizedBox(height: defaultPadding * 2),
                                        Expanded(
                                          child: CounselingRecordTable(),
                                        ),
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
              );
            }
          }),
    );
  }
}
