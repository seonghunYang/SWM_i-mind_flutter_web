import 'package:ai_counseling_platform/screens/custom_screen/components/pretty_padding_button.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ServiceInfo extends StatelessWidget {
  const ServiceInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff7f8fc),
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 15, vertical: defaultPadding * 3),
      child: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 3,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                "우리 센터만의 맞춤 모델로\n상담효율과 상담 만족도를 높이세요",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 28,
                    ),
              ),
              SizedBox(
                height: defaultPadding * 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrettyPaddingButton(
                    text: "상담사 이용가이드 보러가기",
                    backgroundColor: Color(0xff506df5),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: defaultPadding * 2,
                  ),
                  PrettyPaddingButton(
                    text: "센터 문의하기",
                    backgroundColor: Color(0xff808aaa),
                    onPressed: () {},
                  ),
                ],
              )
            ]),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(
                defaultPadding * 5,
              ),
              child: Image.asset(
                "assets/images/main_tech_logic.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
