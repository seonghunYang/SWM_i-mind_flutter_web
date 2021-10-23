import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../../constants.dart';
import 'action_label_wrap.dart';

class LogicSettingBlock extends StatelessWidget {
  const LogicSettingBlock({
    Key? key,
    required this.title,
    required this.titleButtonList,
    required this.onSelectedButton,
    required this.onTapButton,
    this.subContent,
  }) : super(key: key);
  final String title;
  final List<String> titleButtonList;
  final Widget? subContent;

  final void Function(int, bool) onSelectedButton;
  final void Function() onTapButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: defaultPadding * 2,
          ),
          GroupButton(
            // selectedTextStyle: TextStyle(),
            groupRunAlignment: GroupRunAlignment.start,
            mainGroupAlignment: MainGroupAlignment.start,
            selectedButton: 0,
            isRadio: true,
            spacing: 20,
            onSelected: onSelectedButton,
            buttons: titleButtonList,
            textPadding: EdgeInsets.zero,
            selectedColor: Colors.black,
            borderRadius:
                BorderRadius.all(Radius.circular(defaultPadding * 0.5)),
          ),
          SizedBox(
            height: defaultPadding * 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: onTapButton,
                  child: Text(
                    "다음",
                    style: Theme.of(context).textTheme.bodyText1,
                  ))
            ],
          )
          // SizedBox(
          //   height: defaultPadding * 3,
          // ),

          // Text(
          //   "1-1. 대표행동 선택",
          //   style: Theme.of(context)
          //       .textTheme
          //       .subtitle1!
          //       .copyWith(fontWeight: FontWeight.bold),
          // ),
          // SizedBox(
          //   height: defaultPadding * 2,
          // ),
          // Expanded(child: ActionLabelWrap()),
        ],
      ),
    );
  }
}
