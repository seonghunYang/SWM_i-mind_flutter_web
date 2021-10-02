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
                    "인공지능\n아동심리상담 플랫폼",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.white, fontSize: 50, height: 1.25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "인공지능 기반 아동심리분석으로 상담업무의 효율성을 높이세요!",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(
                    height: 40,
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
                  )
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
