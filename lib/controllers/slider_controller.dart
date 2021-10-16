import 'package:flutter/material.dart';

class SliderController extends ChangeNotifier {
  late dynamic value;
  final String tooltipMessage;
  SliderController({required this.value, this.tooltipMessage = ""});

  void updateValue(double newValue) {
    value = newValue.round();
  }
}
