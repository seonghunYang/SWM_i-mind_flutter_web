import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'package:dotted_border/dotted_border.dart';

class CustomLogicLayer extends StatelessWidget {
  const CustomLogicLayer({
    Key? key,
    required this.index,
    required this.title,
    required this.color,
    required this.onTap,
    required this.isSelected,
    required this.isFinished,
    required this.finishedText,
  }) : super(key: key);

  final int index;
  final String title;
  final Color color;
  final void Function(int) onTap;
  final bool isSelected;
  final bool isFinished;
  final String finishedText;

  Widget getChildWidget() {
    if (!isFinished) {
      return DottedBorder(
        dashPattern: [6, 3],
        borderType: BorderType.RRect,
        radius: Radius.circular(5.0),
        strokeWidth: 3.0,
        color: isSelected ? color : kContainerColor,
        child: Container(
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color.withOpacity(isSelected ? 1 : 0.5),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          height: isSelected ? 35 : 30,
          child: Icon(
            Icons.add,
            size: 20,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Container(
        width: 200,
        alignment: Alignment.center,
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Text(
          finishedText,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${index + 1}. $title",
            style: Theme.of(context).textTheme.bodyText1),
        SizedBox(
          width: defaultPadding * 1.5,
        ),
        InkWell(
          onTap: () {
            onTap(index);
          },
          child: getChildWidget(),
        )
      ],
    );
  }
}
