import 'package:flutter/material.dart';

import '../../../constants.dart';

class StepperItem extends StatelessWidget {
  const StepperItem({
    Key? key,
    required this.text,
    required this.numberKey,
    this.width,
    this.fontSize = 12,
    this.borderWidth = 2.0,
    this.currentNumberKey,
    this.selectedNumberKeyList,
    this.padding = const EdgeInsets.symmetric(
        horizontal: defaultPadding * 1.5, vertical: defaultPadding * 1.5),
  })  : assert(currentNumberKey != null || selectedNumberKeyList != null),
        super(key: key);

  final String text;
  final int numberKey;
  final int? currentNumberKey;
  final double? width;
  final double fontSize;
  final double borderWidth;
  final List<int>? selectedNumberKeyList;
  final EdgeInsetsGeometry padding;

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
      padding: padding,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isSelected() ? kSelectedContainerColor : kContainerColor,
          border: Border.all(color: kContainerColor, width: borderWidth),
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontSize: fontSize,
            color: isSelected() ? Colors.white : kSelectedContainerColor),
      ),
    );
  }
}
