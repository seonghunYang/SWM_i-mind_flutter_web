import 'package:ai_counseling_platform/screens/components/rounded_button.dart';
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
      height: 800,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/main_bg.png'), fit: BoxFit.fill),
      ),
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
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.white, fontSize: 45, height: 1.25),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Text(
                    "i-mind는 인공지능기반 아동놀이영상 분석으로 업무의 효율성을 높이고 대시보드를 통해 고객 정보관리와 상담 정보관리까지 지원되는 심리상담센터 현장에 최적화된 통합 서비스입니다.",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(
                    height: defaultPadding * 3,
                  ),
                  RoundedButton(
                    text: Text(
                      "바로 시작하기",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
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
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: defaultPadding * 10),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: const FittedBox(
                    fit: BoxFit.cover,
                    // child: Image(
                    //   image: AssetImage("assets/images/main_dashboard.jpeg"),
                    // ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
