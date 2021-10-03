import 'package:flutter/material.dart';

class SliderController extends ChangeNotifier {
  double value = 50;

  void updateValue(double newValue) {
    value = newValue;
    notifyListeners();
  }
}
