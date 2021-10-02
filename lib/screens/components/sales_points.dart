import 'package:ai_counseling_platform/screens/components/sales_point_item.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SalesPoints extends StatelessWidget {
  const SalesPoints({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding * 10),
      child: Column(
        children: [
          SalesPointItem(
            title: Text(
              "인공지능 기반\n업무 자동화 시스템으로\n상담화 효율 극대화",
              style: Theme.of(context).textTheme.headline2,
            ),
            subTitle: Text(
              "객체추적, 행동인식, 얼굴식별 등 캐치만의 인공지능 기술을 활용하여\n부모와 아이의 상호작용 패턴을 자동으로 분석합니다",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            imageSrc: "assets/images/main_platform_info_transparent.png",
            tag: "1",
          ),
          const SizedBox(
            height: 100,
          ),
          SalesPointItem(
            title: Text(
              "우리 센터의 상담에 적합한\n맞춤 모델 설계",
              style: Theme.of(context).textTheme.headline2,
            ),
            subTitle: Text(
              "플랫폼을 통해 모델을 쉽게 커스텀하여\n자신의 심리상담센터에 맞는 최적의 모델을 만들 수 있습니다.",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            imageSrc: "assets/images/main_salespoint_custom_demo.png",
            tag: "2",
          ),
          const SizedBox(
            height: 100,
          ),
          SalesPointItem(
            title: Text(
              "체계적인 시스템을 통한\n지속적인 고객관리",
              style: Theme.of(context).textTheme.headline2,
            ),
            subTitle: Text(
              "하나의 플랫폼으로 상담일지, 분석결과 등을 관리하고 이를 분석하여\n고객을 지속적으로 관리해 고객에게 최고의 상담경험을 줄 수 있습니다.",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            imageSrc: "assets/images/main_customer_manage.png",
            tag: "3",
          ),
          const SizedBox(
            height: 100,
          ),
          SalesPointItem(
            title: Text(
              "표준화된 시스템을 통한\n상담 품질 보장",
              style: Theme.of(context).textTheme.headline2,
            ),
            subTitle: Text(
              "심라상담센터에 표준화된 상담 시스템을 도입하여\n심리상담의 품질을 보장하고 상담사 교육 비용을 절감할 수 있습니다.",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            imageSrc: "assets/images/main_salespoint_quality.png",
            tag: "4",
          ),
        ],
      ),
    );
  }
}
