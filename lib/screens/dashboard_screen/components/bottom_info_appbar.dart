import 'package:flutter/material.dart';

import '../../../constants.dart';

class BottomInfoAppBar extends StatelessWidget with PreferredSizeWidget {
  const BottomInfoAppBar({
    Key? key,
    required this.infoList,
    required this.title,
    required this.onTap,
    this.isLeading = true,
  }) : super(key: key);

  final List<Widget> infoList;
  final String title;
  final void Function() onTap;
  final bool isLeading;

  @override
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: defaultPadding * 1.5, horizontal: defaultPadding * 3),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: infoList),
        ),
      ),
      elevation: 1,
      titleSpacing: 20,
      leading: isLeading
          ? InkWell(
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.grey,
              ),
              onTap: onTap,
            )
          : null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
      ),
    );
  }
}
