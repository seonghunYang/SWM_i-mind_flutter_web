import 'package:flutter/material.dart';

import '../../../constants.dart';

class StepperLine extends StatelessWidget {
  const StepperLine({
    Key? key,
    required this.numberKey,
    this.currentNumberKey,
    this.selectedNumberKeyList,
  })  : assert(currentNumberKey != null || selectedNumberKeyList != null),
        super(key: key);

  final int numberKey;
  final int? currentNumberKey;
  final List<int>? selectedNumberKeyList;

  bool isSelected() {
    if (currentNumberKey != null) {
      return numberKey <= currentNumberKey!;
    } else {
      return selectedNumberKeyList!.contains(numberKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 40,
      color: isSelected() ? kSelectedContainerColor : kContainerColor,
    );
  }
}
