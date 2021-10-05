import 'package:flutter/cupertino.dart';
import 'package:ai_counseling_platform/model/logic_block.dart';

class CustomLogicController extends ChangeNotifier {
  List<LogicBlock> selectedLogicList = [
    LogicBlock(label: "거리 처리", value: "1"),
    LogicBlock(label: "행동 분류 처리", value: "2"),
  ];

  void addLogic(LogicBlock logic) {
    selectedLogicList.add(logic);
    notifyListeners();
  }

  void removeLogic(int index) {
    selectedLogicList.removeAt(index);
    notifyListeners();
  }

  void reOrderLogic(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final LogicBlock item = selectedLogicList.removeAt(oldIndex);
    selectedLogicList.insert(newIndex, item);
    notifyListeners();
  }
}
