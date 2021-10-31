import 'package:ai_counseling_platform/controllers/logic_custom_controller.dart';
import 'package:ai_counseling_platform/model/custom_indiactor_save.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/src/provider.dart';
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
  String getSubText(List<String> list) {
    String value = "";
    for (int i = 0; i < list.length; i++) {
      value += list[i];
      value += ", ";
    }
    return value;
  }

  Widget getSelectedContent(LogicCustomController logicCustomController) {
    CustomIndicatorSave indicatorSave =
        logicCustomController.customDbList[widget.index];
    switch (indicatorSave.selectedIndex) {
      case 0:
        return LogicSettingOne(
          updateSelectedIndex: (int newIndex) {
            logicCustomController.updateFinishIndex(widget.index, newIndex);
          },
          updateStepOneText: (String newText) {
            logicCustomController.updateStepOneText(widget.index, newText);
          },
        );
      case 1:
        return LogicSettingTwo(
          updateSelectedIndex: (int newIndex) {
            logicCustomController.updateFinishIndex(widget.index, newIndex);
          },
          updateStepTwoText: (String newText) {
            logicCustomController.updateStepTwoText(widget.index, newText);
          },
          selectedValue: indicatorSave.stepTwoText,
          updateSubContent: (String newValue, bool isSelected) {
            logicCustomController.updateStepTwoSubList(
                widget.index, newValue, isSelected);
          },
        );
      case 2:
        return LogicSettingThree(
          updateSelectedIndex: (int newIndex) {
            logicCustomController.updateFinishIndex(widget.index, newIndex);
          },
          updateStepThreeText: (String newText) {
            logicCustomController.updateStepThreeText(widget.index, newText);
          },
        );
      case 3:
        return LogicSettingFour(
          updateSelectedIndex: (int newIndex) {
            logicCustomController.updateFinishIndex(widget.index, newIndex);
          },
          updateStepFourText: (String newText) {
            logicCustomController.updateStepFourText(widget.index, newText);
          },
          selectedValue: indicatorSave.stepFourText,
          updateSubContent: (String newValue, bool isSelected) {
            logicCustomController.updateStepTwoSubList(
                widget.index, newValue, isSelected);
          },
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final LogicCustomController logicCustomController =
        context.watch<LogicCustomController>();
    CustomIndicatorSave indicatorSave =
        logicCustomController.customDbList[widget.index];
    return Column(
      children: [
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
                      isFinished: indicatorSave.finishedIndexList.contains(0),
                      index: 0,
                      title: "분석 대상",
                      color: kSelectedContainerColor,
                      onTap: (int newIndex) {
                        logicCustomController.updateSelectedIndex(
                            widget.index, newIndex);
                      },
                      isSelected: 0 == indicatorSave.selectedIndex,
                      finishedText: indicatorSave.stepOneText,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomLogicLayer(
                      isFinished: indicatorSave.finishedIndexList.contains(1),
                      index: 1,
                      title: "자료 선택",
                      color: kSelectedContainerColor,
                      onTap: (int newIndex) {
                        logicCustomController.updateSelectedIndex(
                            widget.index, newIndex);
                      },
                      isSelected: 1 == indicatorSave.selectedIndex,
                      finishedText:
                          "${indicatorSave.stepTwoText}\n${getSubText(indicatorSave.stepTwoSubList)}",
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomLogicLayer(
                      isFinished: indicatorSave.finishedIndexList.contains(2),
                      index: 2,
                      title: "분석 방법",
                      color: kSelectedContainerColor,
                      onTap: (int newIndex) {
                        logicCustomController.updateSelectedIndex(
                            widget.index, newIndex);
                      },
                      isSelected: 2 == indicatorSave.selectedIndex,
                      finishedText: indicatorSave.stepThreeText,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomLogicLayer(
                      isFinished: indicatorSave.finishedIndexList.contains(3),
                      index: 3,
                      title: "지표 산출",
                      color: kSelectedContainerColor,
                      onTap: (int newIndex) {
                        logicCustomController.updateSelectedIndex(
                            widget.index, newIndex);
                      },
                      isSelected: 3 == indicatorSave.selectedIndex,
                      finishedText: indicatorSave.stepFourText,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: getSelectedContent(logicCustomController),
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
