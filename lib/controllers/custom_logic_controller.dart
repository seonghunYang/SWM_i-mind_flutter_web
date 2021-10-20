import 'package:flutter/cupertino.dart';
import 'package:ai_counseling_platform/model/logic_block.dart';

class CustomLogicController {
  List<LogicBlock> selectedLogicList = [];

  void addLogic(LogicBlock logic) {
    selectedLogicList.add(logic);
  }

  void removeLogic(int index) {
    selectedLogicList.removeAt(index);
  }

  void reOrderLogic(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final LogicBlock item = selectedLogicList.removeAt(oldIndex);
    selectedLogicList.insert(newIndex, item);
  }
}
