import 'package:flutter/material.dart';

class LogicBlock {
  final String label;
  final String value;

  LogicBlock({
    required this.label,
    required this.value,
  });
}

List<LogicBlock> logicList = [
  LogicBlock(label: "부모-아이 발화 빈도 비교", value: "3"),
  LogicBlock(label: "대표행동 분석", value: "4"),
  LogicBlock(label: "행동 지속성 분석", value: "5"),
  LogicBlock(label: "아이 화면이탈률 분석", value: "6"),
  LogicBlock(label: "표준편차 분석", value: "7"),
  LogicBlock(label: "부모-아이 거리측정", value: "8"),
  LogicBlock(label: "시계열 변화량 분석", value: "9"),
  LogicBlock(label: "부모-아이 대표감정 분석", value: "10"),
  LogicBlock(label: "부모-아이 감정비율 분석", value: "11"),
];
