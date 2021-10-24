import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'action_label_wrap.dart';
import 'logic_setting_block.dart';
import 'package:group_button/group_button.dart';

class LogicSettingFour extends StatefulWidget {
  LogicSettingFour({
    Key? key,
    required this.updateStepFourText,
    required this.updateSelectedIndex,
    required this.selectedValue,
    required this.updateSubContent,
  }) : super(key: key);

  final void Function(String) updateStepFourText;
  final void Function(int) updateSelectedIndex;
  final String selectedValue;
  final void Function(String, bool) updateSubContent;

  @override
  State<LogicSettingFour> createState() => _LogicSettingFourState();
}

class _LogicSettingFourState extends State<LogicSettingFour> {
  List<String> labelList = ["최대값 비교", "최소값 비교", "평균값 비교", "편차 비교"];

  int selectedIndex = 0;
  bool isTap = false;

  Widget? getSubContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: defaultPadding * 3,
        ),
        Text(
          "4-1. 데이터 속성",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: defaultPadding * 3,
        ),
        GroupButton(
          // selectedTextStyle: TextStyle(),
          groupRunAlignment: GroupRunAlignment.start,
          mainGroupAlignment: MainGroupAlignment.start,
          selectedButton: 0,
          isRadio: true,
          spacing: 20,
          runSpacing: 10,
          onSelected: (index, bool) {
            setState(() {
              selectedIndex = index;
            });
          },
          buttons: ["시간", "확률(%)", "상대거리", "빈도수"],
          textPadding: EdgeInsets.zero,
          selectedColor: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(defaultPadding * 0.5)),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Text(
          "4-2. 지표유형 선택",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Row(
          children: [
            GroupButton(
              // selectedTextStyle: TextStyle(),
              groupRunAlignment: GroupRunAlignment.start,
              mainGroupAlignment: MainGroupAlignment.start,
              selectedButton: 0,
              isRadio: true,
              spacing: 20,
              runSpacing: 10,
              onSelected: (index, bool) {
                setState(() {
                  selectedIndex = index;
                });
              },
              buttons: ["수치형", "범주형"],
              textPadding: EdgeInsets.zero,
              selectedColor: Colors.black,
              borderRadius:
                  BorderRadius.all(Radius.circular(defaultPadding * 0.5)),
            ),
            SizedBox(
              width: defaultPadding * 2,
            ),
            if (selectedIndex == 0)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75,
                              horizontal: defaultPadding * 0.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding * 0.5,
                    ),
                    Text(
                      "~",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      width: defaultPadding * 0.5,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding * 2,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isTap = true;
                          });
                        },
                        child: Text(
                          "선택",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 11),
                        )),
                    Spacer(
                      flex: 6,
                    )
                  ],
                ),
              ),
          ],
        ),
        if (isTap)
          SizedBox(
            height: defaultPadding * 2,
          ),
        if (isTap)
          Expanded(
            child: Column(
              children: List.generate(5, (index) {
                return Row(
                  children: [
                    Expanded(child: IndicatorInputCell(index: index * 2 + 1)),
                    Expanded(child: IndicatorInputCell(index: index * 2 + 2)),
                  ],
                );
              }),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LogicSettingBlock(
      height: isTap ? 450 : 280,
      title: "4. 지표 산출",
      titleButtonList: labelList,
      onSelectedButton: (int index, _) {
        widget.updateStepFourText(labelList[index]);
      },
      onTapButton: () {
        widget.updateSelectedIndex(3);
      },
      subContent: getSubContent(context),
    );
  }
}

class IndicatorInputCell extends StatelessWidget {
  const IndicatorInputCell({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$index   <=",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          width: defaultPadding,
        ),
        Expanded(
          flex: 2,
          child: TextField(
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                  vertical: defaultPadding * 0.75,
                  horizontal: defaultPadding * 0.75),
            ),
          ),
        ),
        Spacer(
          flex: 1,
        )
      ],
    );
  }
}
