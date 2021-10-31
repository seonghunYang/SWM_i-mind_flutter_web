import 'package:ai_counseling_platform/controllers/scrollable_position_controller.dart';
import 'package:ai_counseling_platform/controllers/stepper_controller.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class StepperRemoteButtons extends StatelessWidget {
  const StepperRemoteButtons({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: defaultPadding * 28,
        vertical: defaultPadding * 4,
      ),
      child:
          Consumer<StepperController>(builder: (context, stepperController, _) {
        int currentNumberKey = stepperController.currentNumberKey;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                if (currentNumberKey > 0) {
                  stepperController.minusCurrentNumberKey();
                  context
                      .read<ScrollPositionController>()
                      .scrollToPosition(scrollController);
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
            if (currentNumberKey < 2)
              InkWell(
                onTap: () {
                  if (currentNumberKey < 2) {
                    stepperController.plusCurrentNumberKey();
                    context
                        .read<ScrollPositionController>()
                        .scrollToPosition(scrollController);
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
        );
      }),
    );
  }
}
