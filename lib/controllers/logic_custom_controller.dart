import 'package:ai_counseling_platform/model/custom_indiactor_save.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/custom_logic.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';

class LogicCustomController extends ChangeNotifier {
  List<CustomLogic> customList = [
    CustomLogic(
      index: 0,
    ),
  ];

  List<CustomIndicatorSave> customDbList = [
    CustomIndicatorSave(),
  ];

  void addLogicCustomer() {
    customDbList.add(CustomIndicatorSave());
    customList.add(CustomLogic(
      index: customList.length,
    ));
    notifyListeners();
  }

  int getStepFourTypeIndex(int index) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    return customIndicatorSave.stepFourTypeSelectedIndex;
  }

  bool getIsTap(int index) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    return customIndicatorSave.isTap;
  }

  List<TextEditingController> getStepFourindicatorTextList(int index) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    return customIndicatorSave.indicatorTextList;
  }

  void updateStepTwoSubList(int index, String newValue, bool isSelected) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    if (isSelected) {
      customIndicatorSave.stepTwoSubList.add(newValue);
    } else {
      customIndicatorSave.stepTwoSubList.remove(newValue);
    }
    notifyListeners();
  }

  void updateSelectedIndex(int index, int newIndex) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    customIndicatorSave.selectedIndex = newIndex;
    notifyListeners();
  }

  void updateTap(int index) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    customIndicatorSave.isTap = !customIndicatorSave.isTap;
    notifyListeners();
  }

  void updateFinishIndex(int index, int newIndex) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    if (!customIndicatorSave.finishedIndexList.contains(newIndex)) {
      customIndicatorSave.finishedIndexList.add(newIndex);
    }
    updateSelectedIndex(index, newIndex + 1);
    notifyListeners();
  }

  void updateStepOneText(int index, String newText) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    customIndicatorSave.stepOneText = newText;
    notifyListeners();
  }

  void updateStepTwoText(int index, String newText) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    customIndicatorSave.stepTwoText = newText;
    notifyListeners();
  }

  void updateStepThreeText(int index, String newText) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    customIndicatorSave.stepThreeText = newText;
    notifyListeners();
  }

  void updateStepFourText(int index, int textIndex) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    customIndicatorSave.stepFourText = stepFourlabelList[textIndex];
    notifyListeners();
  }

  void updateStepFourTypeIndex(int index, int selctedIndex) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    customIndicatorSave.stepFourTypeSelectedIndex = selctedIndex;
    notifyListeners();
  }

  void updateIndicatorName(int index, String newText) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    customIndicatorSave.indicatorName = newText;
    notifyListeners();
  }

  void updateFinishedControl(int index) {
    CustomIndicatorSave customIndicatorSave = customDbList[index];
    customIndicatorSave.isFinished = !customIndicatorSave.isFinished;
    notifyListeners();
  }
}
