import 'package:flutter/material.dart';

import '../../../constants.dart';

class StepperFinish extends StatelessWidget {
  const StepperFinish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.check_circle,
          color: kSelectedContainerColor,
          size: 100,
        ),
        SizedBox(
          height: defaultPadding * 3,
        ),
        Text(
          "문의해주셔서 감사드립니다!",
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 28),
        ),
        SizedBox(
          height: defaultPadding * 2,
        ),
        Text(
          "선택해주신 분석지표 로직으로 문의가 잘 접수되었으며",
          style: Theme.of(context).textTheme.bodyText1!,
        ),
        Text(
          "영업시간 기준으로 만 하루 이내에 가입해주신 이메일로 답변드리겠습니다.",
          style: Theme.of(context).textTheme.bodyText1!,
        ),
        SizedBox(
          height: defaultPadding * 10,
        ),
        Container(),
      ],
    );
  }
}
