import 'package:ai_counseling_platform/controllers/chips_controller.dart';
import 'package:ai_counseling_platform/controllers/stepper_controller.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class ActionLabelWrap extends StatelessWidget {
  const ActionLabelWrap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 20),
      child: Consumer<ChipsController>(builder: (context, chipsController, __) {
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: labels
              .map(
                (item) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        int index = labels.indexOf(item);
                        if (chipsController.selectedNumberKeyList
                            .contains(index)) {
                          chipsController.removeSelectedNumberKeyList(index);
                        } else {
                          chipsController.updateSelectedNumberKeyList(index);
                        }
                      },
                      child: StepperItem(
                        text: item,
                        numberKey: labels.indexOf(item),
                        selectedNumberKeyList:
                            chipsController.selectedNumberKeyList,
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: defaultPadding * 0.75),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        );
      }),
    );
  }
}
