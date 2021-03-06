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

const List<Map> indicator = [
  {
    "indicator": [10, 8, 6, 6, 8],
  },
  {
    "indicator": [8, 8, 4, 8, 7],
    "result": [48, 139, 18.6, 0.27],
  },
];

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
    CounselingRecordController counselingRecordController =
        context.watch<CounselingRecordController>();
    int currentIndex = counselingRecordController.currentIndex;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BottomInfoAppBar(
        onTap: () {
          context.read<CounselingRecordController>().updateCurrentIndex();
          customerController.unSelectCustomer();
        },
        title: selectedCustomer.childName,
        infoList: [
          ProfileInfoCell(
            title: "?????? ??????",
            info: selectedCustomer.parentName,
          ),
          ProfileInfoCell(
            title: "?????? ??????",
            info: "${selectedCustomer.parentAge}???",
          ),
          ProfileInfoCell(
            title: "?????? ??????",
            info: "${selectedCustomer.childAge}??????",
          ),
          ProfileInfoCell(
            title: "??????",
            info: selectedCustomer.childGender,
          ),
          ProfileInfoCell(
            title: "?????????",
            info: selectedCustomer.email,
          ),
          ProfileInfoCell(
            title: "????????????",
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
              context
                  .read<CounselingRecordController>()
                  .setCounselingRecordList(data["counselingRecordList"]["list"],
                      selectedCustomer.childName);
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
                                            "?????? ?????? ?????????",
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
                                              [6, 8, 6, 10, 8]
                                                  .sublist(0, 4 + currentIndex),
                                              [4, 6, 6, 8, 8]
                                                  .sublist(0, 4 + currentIndex),
                                              [3, 4, 4, 6, 4]
                                                  .sublist(0, 4 + currentIndex),
                                              [4, 4, 6, 6, 9]
                                                  .sublist(0, 4 + currentIndex),
                                              [4, 4, 6, 8, 7]
                                                  .sublist(0, 4 + currentIndex),
                                            ],
                                            lineChartBarColorList: [
                                              Color(0xff4af699),
                                              Color(0xffaa4cfc),
                                              Color(0xff27b6fc),
                                              Colors.yellow,
                                              Colors.deepOrangeAccent,
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
                                            "?????? ????????????",
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
                                                text: "?????? ??????",
                                                isSquare: false,
                                                size: 12,
                                              ),
                                              ChartIndicator(
                                                color: kSelectedContainerColor,
                                                text: "?????? ????????????",
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
                                              "?????? ??????",
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
                                                text: "?????? ?????? ??????")
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
