import 'package:ai_counseling_platform/model/linechart_metadata.dart';
import 'package:ai_counseling_platform/model/linechart_rawdata.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/screens/dashboard_counseling_record_manage_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart_indicator.dart';
import 'line_area_chart.dart';

class StatAnalysisCard extends StatelessWidget {
  const StatAnalysisCard({
    Key? key,
    required this.videoSeconds,
    required this.videoPlayerController,
    required this.pointVideoDuration,
    required this.title,
    required this.tooltipMessage,
    this.hintMessageList = const [],
    required this.singleMainContent,
    required this.singleSubContent,
    this.multiMainChild,
    this.multiSubChild,
    this.singleMainContentFlex = 4,
    this.singleSubContentFlex = 1,
    this.isTooltip = true,
  }) : super(key: key);

  final int videoSeconds;
  final VideoPlayerController videoPlayerController;
  final Future Function(int) pointVideoDuration;

  final String title;
  final String tooltipMessage;
  final List<String> hintMessageList;
  final Widget singleMainContent;
  final Widget singleSubContent;
  final Widget? multiMainChild;
  final Widget? multiSubChild;
  final int singleMainContentFlex;
  final int singleSubContentFlex;
  final bool isTooltip;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                if (isTooltip)
                  Tooltip(
                    padding: EdgeInsets.all(defaultPadding),
                    message: tooltipMessage,
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    decoration: BoxDecoration(color: Colors.black87),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List<Text>.generate(
                hintMessageList.length,
                (index) => Text(hintMessageList[index],
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Row(
              children: [
                Expanded(
                  flex: singleMainContentFlex,
                  child: singleMainContent,
                ),
                if (singleSubContentFlex != 0)
                  Expanded(
                    child: singleSubContent,
                    flex: singleSubContentFlex,
                  ),
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            if (multiMainChild != null)
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: multiMainChild!,
                  ),
                  Expanded(
                    child: multiSubChild!,
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
