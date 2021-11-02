import 'package:ai_counseling_platform/screens/components/rounded_button.dart';
import 'package:ai_counseling_platform/screens/custom_screen/custom_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class AboveTheFold extends StatelessWidget {
  const AboveTheFold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 730,
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: defaultPadding * 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "스마트한 심리상담을 위한\n단 하나의 플랫폼",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 45, height: 1.25, wordSpacing: 0),
                  ),
                  const SizedBox(
                    height: defaultPadding * 3,
                  ),
                  Text(
                    "i-mind는 인공지능기반 아동놀이영상 분석으로 업무의 효율성을 높이고\n대시보드를 통해 내담자 정보관리와 상담 정보관리까지 지원되는\n심리상담센터 현장에 최적화된 통합 서비스입니다.",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(height: 1.75),
                  ),
                  const SizedBox(
                    height: defaultPadding * 6,
                  ),
                  RoundedButton(
                    text: Text(
                      "데모 체험하기",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, CustomScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 5,
            child: Image(
              image: AssetImage("assets/images/landing_main.png"),
            ),
          )
        ],
      ),
    );
  }
}
