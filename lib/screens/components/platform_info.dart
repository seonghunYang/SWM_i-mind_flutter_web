import 'package:flutter/material.dart';

import '../../constants.dart';

class PlatformInfo extends StatelessWidget {
  const PlatformInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: defaultPadding * 10),
      child: Column(
        children: [
          Text(
            '심리상담센터 운영을 위한\n"최고의 파트너"',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Text(
            "인공지능 활용한 아동심리분석을 통해 상담사의 업무 효율을 상승시키고 내담자에게 최고의 만족도를 선사하세요",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: defaultPadding * 3,
          ),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: FittedBox(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 1, minHeight: 1),
                child: const Image(
                  image:
                      AssetImage("assets/images/main_salespoint_growth.jpeg"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
