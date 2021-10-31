import 'package:flutter/material.dart';

import '../../../constants.dart';

class BlockContainer extends StatelessWidget {
  const BlockContainer({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(minWidth: 50),
      padding: EdgeInsets.symmetric(
          vertical: defaultPadding * 0.5, horizontal: defaultPadding * 1.5),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 11),
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
