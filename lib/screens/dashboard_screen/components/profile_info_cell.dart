import 'package:flutter/material.dart';

class ProfileInfoCell extends StatelessWidget {
  const ProfileInfoCell({
    Key? key,
    required this.title,
    required this.info,
  }) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title:",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.black.withOpacity(0.70),
                // fontWeight: FontWeight.bold,
              ),
        ),
        Text(" $info", style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
