import 'package:flutter/material.dart';

class SliderController {
  late dynamic value;
  final String tooltipMessage;
  SliderController({required this.value, this.tooltipMessage = ""});

  void updateValue(double newValue) {
    value = newValue.round();
  }
}
