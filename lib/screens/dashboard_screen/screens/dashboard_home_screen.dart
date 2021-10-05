import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
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
                        children: [
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
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.red,
                  height: 500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
