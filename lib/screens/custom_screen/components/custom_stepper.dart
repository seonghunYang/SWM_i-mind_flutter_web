import 'package:ai_counseling_platform/controllers/slider_controller.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_fundemental.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_item.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_line.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/threshold_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_counseling_platform/controllers/stepper_controller.dart';
import '../../../constants.dart';
import 'action_label_wrap.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int currentNumberKey = 0;

  Widget getStepperScreen() {
    switch (currentNumberKey) {
      case 0:
        return const StepperFundemental();
      default:
        return const StepperFundemental();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: defaultPadding * 6,
          ),
          Text(
            "맞춤 모델 만들기",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: defaultPadding * 6,
          ),
          Selector<StepperController, int>(
              selector: (_, stepperController) =>
                  stepperController.currentNumberKey,
              builder: (_, currentNumberKey, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StepperItem(
                      text: "1단계: Fundemental 설정",
                      numberKey: 0,
                      currentNumberKey: currentNumberKey,
                      width: 210,
                    ),
                    StepperLine(
                      numberKey: 1,
                      currentNumberKey: currentNumberKey,
                    ),
                    StepperItem(
                      text: "2단계: 분석 로직 설정",
                      numberKey: 1,
                      currentNumberKey: currentNumberKey,
                      width: 210,
                    ),
                    StepperLine(
                      numberKey: 2,
                      currentNumberKey: currentNumberKey,
                    ),
                    StepperItem(
                      text: "3단계: 요금 설정 및 최종 확인",
                      currentNumberKey: currentNumberKey,
                      numberKey: 2,
                      width: 210,
                    ),
                  ],
                );
              }),
          getStepperScreen(),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: defaultPadding * 28,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    if (currentNumberKey > 0) {
                      setState(() {
                        currentNumberKey--;
                      });
                    }
                  },
                  child: Text(
                    "Back",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16, color: kSelectedContainerColor),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (currentNumberKey < 2) {
                      setState(() {
                        currentNumberKey++;
                      });
                    }
                  },
                  child: StepperItem(
                    text: "Next",
                    numberKey: 7,
                    currentNumberKey: 7,
                    fontSize: 16,
                    borderWidth: 5,
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 6,
                        vertical: defaultPadding * 1.5),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
