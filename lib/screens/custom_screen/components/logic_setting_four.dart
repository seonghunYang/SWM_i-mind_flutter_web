import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'action_label_wrap.dart';
import 'logic_setting_block.dart';
import 'package:group_button/group_button.dart';

class LogicSettingFour extends StatefulWidget {
  LogicSettingFour({
    Key? key,
    required this.updateStepFourText,
    required this.updateSelectedIndex,
    required this.selectedValue,
    required this.updateSubContent,
    required this.typeSelectedIndex,
    required this.updateStepFourTypeIndex,
    required this.indicatorTextControllers,
    required this.updateIsTap,
    required this.isTap,
    required this.selectedButton,
  }) : super(key: key);

  final void Function(int) updateStepFourText;
  final void Function(int) updateStepFourTypeIndex;
  final void Function(int) updateSelectedIndex;
  final void Function() updateIsTap;
  final String selectedValue;
  final void Function(String, bool) updateSubContent;
  final int typeSelectedIndex;
  final bool isTap;
  final int selectedButton;
  final List<TextEditingController> indicatorTextControllers;

  @override
  State<LogicSettingFour> createState() => _LogicSettingFourState();
}

class _LogicSettingFourState extends State<LogicSettingFour> {
  bool isTap = false;
  int selectedIndex = 0;

  Widget? getSubContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: defaultPadding * 3,
        // ),
        // Text(
        //   "4-1. 데이터 속성",
        //   style: Theme.of(context)
        //       .textTheme
        //       .subtitle1!
        //       .copyWith(fontWeight: FontWeight.bold),
        // ),
        SizedBox(
          height: defaultPadding * 3,
        ),
        // GroupButton(
        //   // selectedTextStyle: TextStyle(),
        //   groupRunAlignment: GroupRunAlignment.start,
        //   mainGroupAlignment: MainGroupAlignment.start,
        //   selectedButton: widget.typeSelectedIndex,
        //
        //   isRadio: true,
        //   spacing: 20,
        //   runSpacing: 10,
        //   onSelected: (index, bool) {
        //     widget.updateStepFourTypeIndex(index);
        //   },
        //   buttons: ["시간(초)", "확률(%)", "상대거리", "빈도수(개)"],
        //   textPadding: EdgeInsets.zero,
        //   selectedColor: Colors.black,
        //   borderRadius: BorderRadius.all(Radius.circular(defaultPadding * 0.5)),
        // ),
        // SizedBox(
        //   height: defaultPadding,
        // ),
        Text(
          "4-1. 지표유형 선택",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Row(
          children: [
            GroupButton(
              // selectedTextStyle: TextStyle(),
              groupRunAlignment: GroupRunAlignment.start,
              mainGroupAlignment: MainGroupAlignment.start,
              selectedButton: 0,
              isRadio: true,
              spacing: 20,
              runSpacing: 10,
              onSelected: (index, bool) {
                setState(() {
                  selectedIndex = index;
                });
              },
              buttons: ["수치형", "범주형"],
              textPadding: EdgeInsets.zero,
              selectedColor: Colors.black,
              borderRadius:
                  BorderRadius.all(Radius.circular(defaultPadding * 0.5)),
            ),
            SizedBox(
              width: defaultPadding * 2,
            ),
            if (selectedIndex == 0)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: widget.isTap
                              ? isTap == false
                                  ? "1"
                                  : ""
                              : "",
                          isDense: true,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75,
                              horizontal: defaultPadding),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding * 0.5,
                    ),
                    Text(
                      "~",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      width: defaultPadding * 0.5,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: widget.isTap
                              ? isTap == false
                                  ? "10"
                                  : ""
                              : "",
                          isDense: true,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75,
                              horizontal: defaultPadding * 0.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding * 2,
                    ),
                    TextButton(
                        onPressed: () {
                          widget.updateIsTap();
                          setState(() {
                            isTap = true;
                          });
                        },
                        child: Text(
                          "선택",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 11),
                        )),
                    Spacer(
                      flex: 6,
                    )
                  ],
                ),
              ),
          ],
        ),
        if (widget.isTap)
          SizedBox(
            height: defaultPadding * 3,
          ),
        if (widget.isTap)
          Expanded(
            child: Column(
              children: List.generate(5, (index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: IndicatorInputCell(
                          index: index * 2 + 1,
                          controller:
                              widget.indicatorTextControllers[index * 2],
                        )),
                        Expanded(
                            child: IndicatorInputCell(
                          index: index * 2 + 2,
                          controller:
                              widget.indicatorTextControllers[index * 2 + 1],
                        )),
                      ],
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                  ],
                );
              }),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LogicSettingBlock(
      selectedButton: widget.selectedButton,
      height: widget.isTap ? 550 : 350,
      disableButton: [3],
      title: "4. 지표 산출",
      titleButtonList: stepFourlabelList,
      onSelectedButton: (int index, _) {
        widget.updateStepFourText(index);
      },
      onTapButton: () {
        widget.updateSelectedIndex(3);
      },
      subContent: getSubContent(context),
    );
  }
}

class IndicatorInputCell extends StatelessWidget {
  const IndicatorInputCell({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);
  final int index;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (index != 10)
          Expanded(
            flex: 1,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                // border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                    vertical: defaultPadding * 0.75,
                    horizontal: defaultPadding * 0.75),
              ),
            ),
          ),
        SizedBox(
          width: defaultPadding,
        ),
        if (index != 10)
          Text(
            "이하는",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        if (index == 10)
          Text(
            "나머지는",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        SizedBox(
          width: defaultPadding,
        ),
        Text(
          "$index점",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Spacer(
          flex: 1,
        )
      ],
    );
  }
}
