import 'package:flutter/material.dart';

import '../../constants.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff1e1e1e),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: defaultPadding * 2),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.2),
                bottom: BorderSide(color: Colors.grey, width: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "개인정보처리방침",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(
                  width: defaultPadding * 3,
                ),
                Text(
                  "이메일무단수집거부",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: defaultPadding * 4),
            child: Column(
              children: const [
                Text(
                  "i-mind  |  대표이사 : 양성훈  |  전화 : 031-814-9801  |  팩스 : 031-814-9801  |  이메일 : didtjdgns852@gmail.com",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "i-mind의 모든 컨텐츠는 저작권법의 보호를 받으며 무단전제, 복사, 배포를 금지합니다.",
                  style: TextStyle(color: Colors.grey, height: 2),
                ),
                Text(
                  "Copyright (c) 2021 Legaltech. All Rights Reserved.",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                      height: 3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
