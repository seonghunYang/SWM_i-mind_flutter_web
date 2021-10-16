import 'package:flutter/material.dart';

import '../../../constants.dart';

class RoundedCreateButton extends StatelessWidget {
  const RoundedCreateButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        decoration: BoxDecoration(
            color: kSelectedDashboardTextColor,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Row(children: [
          Icon(
            Icons.add,
            size: 18,
            color: Colors.white,
          ),
          SizedBox(
            width: defaultPadding,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 13),
          )
        ]),
      ),
    );
  }
}
