import 'package:flutter/material.dart';

import '../constants.dart';

class CustomIndicatorSave {
  String stepOneText = "아이";
  String stepTwoText = "대표행동";
  String stepThreeText = "지속시간 구하기";
  int stepFourText = 0;
  List<String> stepTwoSubList = [];
  bool isTap = false;
  int selectedIndex = 0;
  List<int> finishedIndexList = [];
  String indicatorName = "";
  bool isFinished = false;
  int stepFourTypeSelectedIndex = 0;
  List<TextEditingController> indicatorTextList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
}
