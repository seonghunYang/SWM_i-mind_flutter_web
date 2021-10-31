import 'package:flutter/cupertino.dart';

class BacktestingController extends ChangeNotifier {
  String selectedFileName = "";
  bool isLoading = false;
  bool stepTwo = false;
  bool stepTwoLoading = false;
  bool stepThree = false;
  bool isShowResult = false;

  updateStepTwo() {
    stepTwo = !stepTwo;
    notifyListeners();
  }

  updateStepThree() {
    stepThree = !stepThree;
    notifyListeners();
  }

  updateLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  updateStepTwoLoading() {
    stepTwoLoading = !stepTwoLoading;
    notifyListeners();
  }

  updateShowResult() {
    isShowResult = !isShowResult;
    notifyListeners();
  }

  updateFileName(String fileName) {
    selectedFileName = fileName;
    notifyListeners();
  }
}
