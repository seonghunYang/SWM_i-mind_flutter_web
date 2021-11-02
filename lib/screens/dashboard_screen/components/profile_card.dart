import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.isBorder,
  }) : super(key: key);

  final bool isBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding * 3,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
          color: kDashboardMenuColor,
          border: isBorder
              ? Border(bottom: BorderSide(color: Colors.grey, width: 0.3))
              : null),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_outlined,
            color: Colors.grey,
          ),
          SizedBox(width: defaultPadding * 3),
          CircleAvatar(
            backgroundImage: AssetImage(
              "assets/images/main_customer_manage.png",
              // width: 36.0,
              // height: 36.0,
            ),
          ),
          SizedBox(width: defaultPadding * 1.5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Text(
              '권윤정 상담사',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(width: defaultPadding * 3),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
