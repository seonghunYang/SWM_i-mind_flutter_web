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
  LogicBlock(label: "위험도 감지", value: "3"),
  LogicBlock(label: "상호작용 처리", value: "4"),
];
