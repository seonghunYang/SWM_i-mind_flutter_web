import 'package:ai_counseling_platform/controllers/scrollable_position_controller.dart';
import 'package:ai_counseling_platform/controllers/slider_controller.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_advanced.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_back_testing.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_finish.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_fundemental.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_item.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_line.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_pricing.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_remote_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_counseling_platform/controllers/stepper_controller.dart';
import '../../../constants.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    Key? key,
  }) : super(key: key);

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
            "센터 맞춤모델 만들기",
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
                      text: "3단계: 옵셔 선택 및 문의 완료",
                      currentNumberKey: currentNumberKey,
                      numberKey: 2,
                      width: 210,
                    ),
                  ],
                );
              }),
          Container(
            padding: EdgeInsets.only(
              top: defaultPadding * 8,
            ),
            margin: const EdgeInsets.only(
              left: defaultPadding * 28,
              right: defaultPadding * 28,
              top: defaultPadding * 4,
            ),
            decoration:
                BoxDecoration(border: Border.all(color: kContainerColor)),
            child: Consumer<StepperController>(
              builder: (context, stepperController, _) {
                int currentNumberKey = stepperController.currentNumberKey;

                if (currentNumberKey == 0) {
                  return const StepperFundemental();
                } else if (currentNumberKey == 1) {
                  return StepperAdvanced();
                } else if (currentNumberKey == 2) {
                  return const StepperBackTesting();
                } else {
                  return const StepperFinish();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
