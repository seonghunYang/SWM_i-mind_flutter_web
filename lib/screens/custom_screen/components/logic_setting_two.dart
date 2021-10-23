import 'package:flutter/material.dart';

import 'logic_setting_block.dart';

class LogicSettingTwo extends StatelessWidget {
  LogicSettingTwo({
    Key? key,
    required this.updateStepTwoText,
    required this.updateSelectedIndex,
    required this.selectedValue,
  }) : super(key: key);

  final void Function(String) updateStepTwoText;
  final void Function(int) updateSelectedIndex;
  final String selectedValue;

  List<String> labelList = ["대표행동", "대표감정", "위치"];

  Widget? getSubContent() {
    if (selectedValue == "대표행동") {}
  }

  @override
  Widget build(BuildContext context) {
    return LogicSettingBlock(
      title: "2. 자료 선택",
      titleButtonList: labelList,
      onSelectedButton: (int index, _) {
        updateStepTwoText(labelList[index]);
      },
      onTapButton: () {
        updateSelectedIndex(1);
      },
    );
  }
}
