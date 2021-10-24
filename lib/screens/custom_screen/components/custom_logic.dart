import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../constants.dart';
import 'action_label_wrap.dart';
import 'customer_logic_layer.dart';
import 'logic_custom.dart';
import 'package:dotted_border/dotted_border.dart';

import 'logic_setting_four.dart';
import 'logic_setting_one.dart';
import 'logic_setting_three.dart';
import 'logic_setting_two.dart';

class CustomLogic extends StatefulWidget {
  const CustomLogic({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<CustomLogic> createState() => _CustomLogicState();
}

class _CustomLogicState extends State<CustomLogic> {
  int selectedIndex = 0;
  List<int> finishedIndexList = [];
  String stepOneText = "아이";
  String stepTwoText = "대표행동";
  String stepThreeText = "지속시간 구하기";
  String stepFourText = "최대값 비교";
  List<String> stepTwoSubList = [];

  void updateStepTwoSubList(String newValue, bool isSelected) {
    if (isSelected) {
      setState(() {
        stepTwoSubList.add(newValue);
      });
    } else {
      setState(() {
        stepTwoSubList.remove(newValue);
      });
    }
  }

  void updateSelectedIndex(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
  }

  void updateFinishIndex(int newIndex) {
    if (!finishedIndexList.contains(newIndex)) {
      setState(() {
        finishedIndexList.add(newIndex);
      });
    }
    updateSelectedIndex(newIndex + 1);
  }

  void updateStepOneText(String newText) {
    setState(() {
      stepOneText = newText;
    });
  }

  void updateStepTwoText(String newText) {
    setState(() {
      stepTwoText = newText;
    });
  }

  void updateStepThreeText(String newText) {
    setState(() {
      stepThreeText = newText;
    });
  }

  void updateStepFourText(String newText) {
    setState(() {
      stepFourText = newText;
    });
  }

  String getSubText(List<String> list) {
    String value = "";
    for (int i = 0; i < list.length; i++) {
      value += list[i];
      value += ", ";
    }
    return value;
  }

  Widget getSelectedContent() {
    switch (selectedIndex) {
      case 0:
        return LogicSettingOne(
          updateSelectedIndex: updateFinishIndex,
          updateStepOneText: updateStepOneText,
        );
      case 1:
        return LogicSettingTwo(
          updateSelectedIndex: updateFinishIndex,
          updateStepTwoText: updateStepTwoText,
          selectedValue: stepTwoText,
          updateSubContent: updateStepTwoSubList,
        );
      case 2:
        return LogicSettingThree(
          updateSelectedIndex: updateFinishIndex,
          updateStepThreeText: updateStepThreeText,
        );
      case 3:
        return LogicSettingFour(
          updateSelectedIndex: updateFinishIndex,
          updateStepFourText: updateStepFourText,
          selectedValue: stepFourText,
          updateSubContent: updateStepTwoSubList,
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // IndicatorName(index: index),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 5),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IndicatorName(index: widget.index),
                    CustomLogicLayer(
                      isFinished: finishedIndexList.contains(0),
                      index: 0,
                      title: "분석 대상",
                      color: kSelectedContainerColor,
                      onTap: updateSelectedIndex,
                      isSelected: 0 == selectedIndex,
                      finishedText: stepOneText,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomLogicLayer(
                      isFinished: finishedIndexList.contains(1),
                      index: 1,
                      title: "자료 선택",
                      color: kSelectedContainerColor,
                      onTap: updateSelectedIndex,
                      isSelected: 1 == selectedIndex,
                      finishedText:
                          "$stepTwoText\n${getSubText(stepTwoSubList)}",
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomLogicLayer(
                      isFinished: finishedIndexList.contains(2),
                      index: 2,
                      title: "분석 방법",
                      color: kSelectedContainerColor,
                      onTap: updateSelectedIndex,
                      isSelected: 2 == selectedIndex,
                      finishedText: stepThreeText,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomLogicLayer(
                      isFinished: finishedIndexList.contains(3),
                      index: 3,
                      title: "지표 산출",
                      color: kSelectedContainerColor,
                      onTap: updateSelectedIndex,
                      isSelected: 3 == selectedIndex,
                      finishedText: stepFourText,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: getSelectedContent(),
              )
            ],
          ),
        ),
        SizedBox(
          height: defaultPadding * 10,
        )
      ],
    );
  }
}
