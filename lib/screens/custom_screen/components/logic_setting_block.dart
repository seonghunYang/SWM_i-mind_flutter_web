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
    this.disableButton = const [],
    this.height = 200,
    this.selectedButton = 0,
  }) : super(key: key);
  final String title;
  final List<String> titleButtonList;
  final Widget? subContent;
  final int selectedButton;

  final void Function(int, bool) onSelectedButton;
  final void Function() onTapButton;
  final double height;
  final List<int> disableButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
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
            disabledButtons: disableButton,
            // selectedTextStyle: TextStyle(),
            groupRunAlignment: GroupRunAlignment.start,
            mainGroupAlignment: MainGroupAlignment.start,
            selectedButton: selectedButton,
            runSpacing: 10,
            isRadio: true,
            spacing: 20,
            onSelected: onSelectedButton,
            buttons: titleButtonList,
            textPadding: EdgeInsets.zero,
            selectedColor: Colors.black,
            borderRadius:
                BorderRadius.all(Radius.circular(defaultPadding * 0.5)),
          ),
          if (subContent != null) Expanded(child: subContent!),
          SizedBox(
            height: defaultPadding * 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: onTapButton,
                  child: Text(
                    "??????",
                    style: Theme.of(context).textTheme.bodyText1,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
