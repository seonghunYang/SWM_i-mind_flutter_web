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
          "1. 행동 인식의 강도를 선택하세요",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: defaultPadding * 6,
        ),
        ThresholdSlider(
          labelFormatterCallback: (dynamic value, String formattedText) {
            switch (value) {
              case 1:
                return "매우낮음";
              case 2:
                return "낮음";
              case 3:
                return "보통";
              case 4:
                return "높음*";
              case 5:
                return "메우높음";
              default:
                return "낮음";
            }
          },
          tooltipTextFormatterCallback: (dynamic value, String formattedText) {
            switch (value) {
              case 1:
                return "인식강도 매우 낮음, 가능성이 있는 모든 행동 인식";
              case 2:
                return "인식강도 낮음, 명확하게 구별되지 않은 유사한 행동도 식별 ";
              case 3:
                return "보통, 맥락에 맞는 수준의 행동 인식";
              case 4:
                return "높음, 사람이 판단하는 것과 가장 유사한 정도로 구분력이 있는 행동 인식";
              case 5:
                return "메우높음, 명확하게 인식되는 엄격한 수준의 행동 인식";
              default:
                return "낮음";
            }
          },
        ),
        const SizedBox(
          height: defaultPadding * 12,
        ),
        Text(
          "2. 감정 분석의 강도를 선택하세요",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: defaultPadding * 5,
        ),
        ThresholdSlider(
          labelFormatterCallback: (dynamic value, String formattedText) {
            switch (value) {
              case 1:
                return "매우낮음";
              case 2:
                return "낮음";
              case 3:
                return "보통";
              case 4:
                return "높음*";
              case 5:
                return "메우높음";
              default:
                return "낮음";
            }
          },
          tooltipTextFormatterCallback: (dynamic value, String formattedText) {
            switch (value) {
              case 1:
                return "인식강도 매우 낮음, 가능성이 있는 모든 행동 인식";
              case 2:
                return "인식강도 낮음, 명확하게 구별되지 않은 유사한 행동도 식별 ";
              case 3:
                return "보통, 맥락에 맞는 수준의 행동 인식";
              case 4:
                return "높음, 사람이 판단하는 것과 가장 유사한 정도로 구분력이 있는 행동 인식";
              case 5:
                return "메우높음, 명확하게 인식되는 엄격한 수준의 행동 인식";
              default:
                return "낮음";
            }
          },
        ),
        const SizedBox(
          height: defaultPadding * 12,
        ),
        Text(
          "3. 분석 속도 및 정확도를 선택하세요",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: defaultPadding * 3,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("- 대면 해설 상담 등 빠른 결과 도출이 필요하신 분들은 빠른 속도를 선택해주세요.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                )),
            Text("- 정밀 분석 및 온라인 상담 등 시간에 관계없는 분들은 높은 정확도를 선택해주세요",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 2)),
          ],
        ),
        const SizedBox(
          height: defaultPadding * 3,
        ),
        ThresholdSlider(
          defaultValue: 3,
          labelFormatterCallback: (dynamic value, String formattedText) {
            switch (value) {
              case 1:
                return "매우빠른 속도";
              case 2:
                return "빠른 속도";
              case 3:
                return "밸런스*";
              case 4:
                return "높은 정확도";
              case 5:
                return "메우높은 정확도";
              default:
                return "낮음";
            }
          },
          tooltipTextFormatterCallback: (dynamic value, String formattedText) {
            switch (value) {
              case 1:
                return "영상 길이보다 짧은 처리속도, 15프레임 분석수행";
              case 2:
                return "영상 길이정도의 처리시간, 10프레임 분석 수행";
              case 3:
                return "밸런스형, 약 1.5배 처리 속도 소요 5프레임 분석 수행";
              case 4:
                return "약 2배 처리 속도 소요 3프레임 분석 수행, 정밀한 검사 결과 추출";
              case 5:
                return "약 4배 처리 속도 소요, 1프레임 분석 수행, 매우 정밀함 검사 결과 추출";
              default:
                return "낮음";
            }
          },
        ),
        // Container(
        //   child: ToggleSwitch(
        //     minWidth: 150.0,
        //     initialLabelIndex: 0,
        //     cornerRadius: 20.0,
        //     activeFgColor: Colors.white,
        //     inactiveBgColor: kContainerColor,
        //     inactiveFgColor: kSelectedContainerColor,
        //     totalSwitches: 2,
        //     labels: const ["X", "선택"],
        //     iconSize: 30.0,
        //     activeBgColors: const [
        //       [
        //         kSelectedContainerColor,
        //       ],
        //       [
        //         kSelectedContainerColor,
        //       ]
        //     ],
        //     animate:
        //         true, // with just animate set to true, default curve = Curves.easeIn
        //     curve: Curves
        //         .ease, // animate must be set to true when using custom curve
        //     onToggle: (index) {
        //       print('switched to: $index');
        //     },
        //   ),
        // ),
        const SizedBox(
          height: defaultPadding * 12,
        ),
      ],
    );
  }
}
