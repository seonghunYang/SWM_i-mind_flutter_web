import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'action_label_wrap.dart';
import 'logic_setting_block.dart';

class LogicSettingTwo extends StatelessWidget {
  LogicSettingTwo({
    Key? key,
    required this.updateStepTwoText,
    required this.updateSelectedIndex,
    required this.selectedValue,
    required this.updateSubContent,
  }) : super(key: key);

  final void Function(String) updateStepTwoText;
  final void Function(int) updateSelectedIndex;
  final String selectedValue;
  final void Function(String, bool) updateSubContent;

  List<String> labelList = ["대표행동", "대표감정", "위치"];

  Widget? getSubContent(BuildContext context) {
    if (selectedValue == "대표행동" || selectedValue == "대표감정") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: defaultPadding * 3,
          ),
          Text(
            "2-1. $selectedValue 선택",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: defaultPadding * 2,
          ),
          Expanded(
              child: ActionLabelWrap(
            labelList: selectedValue == "대표행동" ? actionLabels : emotionLabels,
            onSelected: (int newIndex, bool isSelected) {
              String newValue = selectedValue == "대표행동"
                  ? actionLabels[newIndex]
                  : emotionLabels[newIndex];
              if (isSelected) {
                updateSubContent(newValue, true);
              } else {
                updateSubContent(newValue, false);
              }
            },
          )),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LogicSettingBlock(
      title: "2. 자료 선택",
      height: 250,
      titleButtonList: labelList,
      onSelectedButton: (int index, _) {
        updateStepTwoText(labelList[index]);
      },
      onTapButton: () {
        updateSelectedIndex(1);
      },
      subContent: getSubContent(context),
    );
  }
}
