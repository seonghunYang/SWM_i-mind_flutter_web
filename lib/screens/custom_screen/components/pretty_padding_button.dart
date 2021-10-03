import 'package:flutter/material.dart';

import '../../../constants.dart';

class PrettyPaddingButton extends StatelessWidget {
  const PrettyPaddingButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
                horizontal: defaultPadding * 2.5,
                vertical: defaultPadding * 2.5),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(backgroundColor)),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
