import 'package:flutter/material.dart';

import 'logic_setting_block.dart';

class LogicSettingOne extends StatelessWidget {
  LogicSettingOne({
    Key? key,
    required this.updateStepOneText,
    required this.updateSelectedIndex,
  }) : super(key: key);

  final void Function(String) updateStepOneText;
  final void Function(int) updateSelectedIndex;

  List<String> labelList = ["아이", "부모", "아이-부모"];

  @override
  Widget build(BuildContext context) {
    return LogicSettingBlock(
      title: "1. 분석 대상",
      titleButtonList: labelList,
      onSelectedButton: (int index, _) {
        updateStepOneText(labelList[index]);
      },
      onTapButton: () {
        updateSelectedIndex(0);
      },
    );
  }
}
