import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'action_label_wrap.dart';
import 'logic_setting_block.dart';

class LogicSettingThree extends StatelessWidget {
  LogicSettingThree({
    Key? key,
    required this.updateStepThreeText,
    required this.updateSelectedIndex,
  }) : super(key: key);

  final void Function(String) updateStepThreeText;
  final void Function(int) updateSelectedIndex;

  List<String> labelList = [
    "지속시간 구하기(초)",
    "거리 구하기(상대거리)",
    "비율 구하기(%)",
    "빈도 구하기(횟수)"
  ];

  @override
  Widget build(BuildContext context) {
    return LogicSettingBlock(
      title: "3. 분석 방법",
      disableButton: [1],
      titleButtonList: labelList,
      onSelectedButton: (int index, _) {
        updateStepThreeText(labelList[index]);
      },
      onTapButton: () {
        updateSelectedIndex(2);
      },
    );
  }
}
