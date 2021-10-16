import 'package:flutter/material.dart';

import '../../constants.dart';

class FormSubmitButton extends StatefulWidget {
  const FormSubmitButton(
      {Key? key, required this.onPressed, required this.title})
      : super(key: key);

  final Future Function() onPressed;
  final String title;

  @override
  _FormSubmitButtonState createState() => _FormSubmitButtonState();
}

class _FormSubmitButtonState extends State<FormSubmitButton> {
  bool isDisable = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisable
          ? null
          : () async {
              setState(() {
                isDisable = true;
              });
              await widget.onPressed();
              setState(() {
                isDisable = false;
              });
            },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kSelectedContainerColor),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
              horizontal: defaultPadding * 5, vertical: defaultPadding * 2),
        ),
      ),
      child: isDisable
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white),
            ),
    );
  }
}
