import 'package:ai_counseling_platform/controllers/counseling_record_controller.dart';
import 'package:ai_counseling_platform/controllers/counseling_report_controller.dart';
import 'package:ai_counseling_platform/controllers/slider_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../constants.dart';

class CounselingReportDialog extends StatelessWidget {
  const CounselingReportDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CounselingReportController counselingReportController =
        context.watch<CounselingReportController>();
    return AlertDialog(
      title: Text(
        "상담일지 작성",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Container(
        width: 800,
        height: 650,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: defaultPadding * 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "최종 결과 등록",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              counselingReportController.setGuideMent();
                            },
                            child: Text("등록"),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kMainColor)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Expanded(
                      child: StatusCell(
                        text: "즐거움",
                        sliderController: counselingReportController.statHappy,
                        enabled: counselingReportController.checkedStatus,
                      ),
                    ),
                    Expanded(
                      child: StatusCell(
                        text: "지속성/몰입도",
                        sliderController:
                            counselingReportController.statPersistence,
                        enabled: counselingReportController.checkedStatus,
                      ),
                    ),
                    Expanded(
                      child: StatusCell(
                        text: "주도성",
                        sliderController:
                            counselingReportController.statLeading,
                        enabled: counselingReportController.checkedStatus,
                      ),
                    ),
                    Expanded(
                      child: StatusCell(
                        text: "밀착도",
                        sliderController:
                            counselingReportController.statSensitivity,
                        enabled: counselingReportController.checkedStatus,
                      ),
                    ),
                    Expanded(
                      child: StatusCell(
                        text: "반복하기",
                        sliderController: counselingReportController.statRepeat,
                        enabled: counselingReportController.checkedStatus,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: defaultPadding * 4,
              ),
              SizedBox(
                height: 250,
                child: LongTextField(
                  title: "아이 강점",
                  textEditingController:
                      counselingReportController.childPositive,
                ),
              ),
              SizedBox(
                height: defaultPadding * 4,
              ),
              SizedBox(
                height: 250,
                child: LongTextField(
                  title: "아이 보완점",
                  textEditingController:
                      counselingReportController.childNegative,
                ),
              ),
              SizedBox(
                height: defaultPadding * 4,
              ),
              SizedBox(
                height: 250,
                child: LongTextField(
                  title: "부모 강점",
                  textEditingController:
                      counselingReportController.parentPositive,
                ),
              ),
              SizedBox(
                height: defaultPadding * 4,
              ),
              SizedBox(
                height: 250,
                child: LongTextField(
                  title: "부모 보완점",
                  textEditingController:
                      counselingReportController.parentNegative,
                ),
              ),
              SizedBox(
                height: defaultPadding * 4,
              ),
              SizedBox(
                height: 150,
                child: LongTextField(
                  title: "총평",
                  textEditingController: counselingReportController.total,
                ),
              ),
              SizedBox(
                height: defaultPadding * 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "뒤로",
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "등록",
          ),
        ),
      ],
    );
  }
}

class LongTextField extends StatelessWidget {
  const LongTextField({
    Key? key,
    required this.title,
    required this.textEditingController,
  }) : super(key: key);
  final String title;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: defaultPadding * 2,
        ),
        Expanded(
          child: TextFormField(
            controller: textEditingController,
            validator: (value) {
              return value!.isNotEmpty ? null : "항목을 입력해주세요";
            },
            maxLines: 20,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding * 1),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

class StatusCell extends StatelessWidget {
  const StatusCell({
    Key? key,
    required this.text,
    required this.sliderController,
    required this.enabled,
  }) : super(key: key);

  final String text;
  final SliderController sliderController;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    CounselingReportController counselingReportController =
        context.read<CounselingReportController>();
    return Row(
      children: [
        SizedBox(
          width: defaultPadding * 2,
        ),
        Tooltip(
          padding: EdgeInsets.all(defaultPadding * 1.5),
          textStyle: TextStyle(fontSize: 12),
          decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.all(Radius.circular(defaultPadding))),
          message: sliderController.tooltipMessage,
          child: Icon(
            Icons.info_outline,
            color: kSelectedDashboardTextColor,
          ),
        ),
        SizedBox(
          width: defaultPadding * 2,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 5,
          child: SfSlider(
            value: sliderController.value,
            onChanged: (value) {
              counselingReportController.updateSliderController(
                  sliderController, value);
            },
            min: 0,
            max: 10,
            interval: 2,
            showLabels: true,
            showTicks: true,
            enableTooltip: true,
            minorTicksPerInterval: 1,
            activeColor: kMainColor,
            inactiveColor: kDasboardTextColor,
          ),
        ),
        SizedBox(
          width: defaultPadding * 4,
        ),
      ],
    );
  }
}
