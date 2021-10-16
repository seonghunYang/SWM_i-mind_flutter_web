import 'dart:html';

import 'package:ai_counseling_platform/controllers/customer_controller.dart';
import 'package:ai_counseling_platform/model/radarchart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/bottom_info_appbar.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/chart_indicator.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/counseling_record_table.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/facial_distribution.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/multi_line_chart.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/profile_info_cell.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/rounded_create_button.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/stats_radar_charts.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/user_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BottomInfoAppBar(
        onTap: () {
          customerController.unSelectCustomer();
        },
        title: "양성훈",
        infoList: [
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
        ],
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
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
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
                              padding: EdgeInsets.only(top: defaultPadding),
                              height: 300,
                              child: Column(
                                children: [
                                  Text(
                                    "최근 상담지표",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  SizedBox(
                                    height: defaultPadding * 2,
                                  ),
                                  Expanded(
                                      child: StatsRadarChart(
                                    indicators: [
                                      ChartIndicator(
                                        color: kSelectedDashboardTextColor,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                              fontWeight: FontWeight.bold),
                                    ),
                                    RoundedCreateButton(
                                        onTap: () {
                                          showUserCreateDialog(context);
                                        },
                                        text: "상담 기록 추가")
                                  ],
                                ),
                                SizedBox(height: defaultPadding * 2),
                                Expanded(child: CounselingRecordTable()),
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
  }
}
