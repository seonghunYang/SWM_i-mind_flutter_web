import 'package:flutter/material.dart';
import 'package:ai_counseling_platform/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final Widget text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
              vertical: defaultPadding * 3, horizontal: defaultPadding * 3.5)),
          backgroundColor: MaterialStateProperty.all(kLandingMainColor),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)))),
      child: text,
    );
  }
}
