import 'package:ai_counseling_platform/constants.dart';
import 'package:ai_counseling_platform/controllers/logic_custom_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'logic_custom.dart';

class StepperAdvanced extends StatelessWidget {
  StepperAdvanced({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "상담센터 핵심 지표와 분석 로직을 선택하세요",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 24),
        ),
        SizedBox(
          height: defaultPadding * 3,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("- 구체적인 수치와 지표선정 기준은 문의 주신 내용을 바탕으로 상호 협의 후 결정합니다.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                )),
            Text("- 원하는 분석 로직이 없으실 경우 지표이름만 작성해주시고 문의 이후 미팅에서 말씀해주시면 됩니다.",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    height: 2)),
          ],
        ),
        const SizedBox(
          height: defaultPadding * 6,
        ),
        Consumer<LogicCustomController>(
            builder: (context, logicCustomController, __) {
          return Column(
            children: logicCustomController.customList,
          );
        }),
        const SizedBox(
          height: defaultPadding * 2,
        ),
        TextButton(
          onPressed: () {
            context.read<LogicCustomController>().addLogicCustomer();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.add), Text("지표추가")],
          ),
        ),
        const SizedBox(
          height: defaultPadding * 3,
        ),
      ],
    );
  }
}
