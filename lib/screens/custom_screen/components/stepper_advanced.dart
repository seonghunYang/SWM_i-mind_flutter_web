import 'package:ai_counseling_platform/constants.dart';
import 'package:ai_counseling_platform/controllers/custom_logic_controller.dart';
import 'package:ai_counseling_platform/model/logic_block.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';

import 'logic_custom.dart';

class StepperAdvanced extends StatelessWidget {
  const StepperAdvanced({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "분석 로직을 커스텀하세요",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: defaultPadding * 6,
        ),
        const LogicCustom(),
        Container(),
      ],
    );
  }
}
