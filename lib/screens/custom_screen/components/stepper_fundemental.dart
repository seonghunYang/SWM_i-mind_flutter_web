import 'package:ai_counseling_platform/screens/custom_screen/components/threshold_slider.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../constants.dart';
import 'action_label_wrap.dart';

class StepperFundemental extends StatelessWidget {
  const StepperFundemental({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "1. 분석할 행동 라벨을 선택하세요",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: defaultPadding * 6,
        ),
        const ActionLabelWrap(),
        const SizedBox(
          height: defaultPadding * 12,
        ),
        Text(
          "2. 행동 인식의 강도를 선택하세요",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: defaultPadding * 5,
        ),
        const ThresholdSlider(),
        const SizedBox(
          height: defaultPadding * 12,
        ),
        Text(
          "3. 얼굴 감정분석 여부를 선택하세요",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: defaultPadding * 6,
        ),
        Container(
          child: ToggleSwitch(
            minWidth: 150.0,
            initialLabelIndex: 0,
            cornerRadius: 20.0,
            activeFgColor: Colors.white,
            inactiveBgColor: kContainerColor,
            inactiveFgColor: kSelectedContainerColor,
            totalSwitches: 2,
            labels: const ["X", "선택"],
            iconSize: 30.0,
            activeBgColors: const [
              [
                kSelectedContainerColor,
              ],
              [
                kSelectedContainerColor,
              ]
            ],
            animate:
                true, // with just animate set to true, default curve = Curves.easeIn
            curve: Curves
                .ease, // animate must be set to true when using custom curve
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
        ),
        const SizedBox(
          height: defaultPadding * 12,
        ),
      ],
    );
  }
}
