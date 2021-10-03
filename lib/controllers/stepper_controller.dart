import 'package:flutter/cupertino.dart';

class StepperController extends ChangeNotifier {
  int currentNumberKey = 0;

  int get getCurrentNumberKey => currentNumberKey;

  void updateCurrentNumberKey(int newValue) {
    currentNumberKey = newValue;
    notifyListeners();
  }
}
