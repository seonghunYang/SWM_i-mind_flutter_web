import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class StepperPricing extends StatelessWidget {
  const StepperPricing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "요금제를 선택하세요",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: defaultPadding * 6,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding * 10),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: PricingCard(
                  columnNum: 6,
                  mainColor: kSelectedContainerColor,
                  text: Text("개인 상담사, 초기 창업 또는 소규모 상담센터",
                      style: Theme.of(context).textTheme.bodyText1),
                  title: Text(
                    "Business",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 20, color: kSelectedContainerColor),
                  ),
                  price: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "3,300",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 20, color: kSelectedContainerColor),
                      ),
                      Text(
                        "원 / 건 ",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: kSelectedContainerColor),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          "첫 1달 100건 무료",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        decoration: const BoxDecoration(
                          color: kSelectedContainerColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: defaultPadding * 3,
              ),
              Expanded(
                flex: 6,
                child: PricingCard(
                  columnNum: 9,
                  title: Text(
                    "Enterprise",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 20, color: kTextColor),
                  ),
                  price: Text(
                    "기업 커스텀",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 20, color: kTextColor),
                  ),
                  text: Text("모든 심리상담센터",
                      style: Theme.of(context).textTheme.bodyText1),
                  mainColor: kTextColor,
                ),
              ),
            ],
          ),
        ),
        Container(),
      ],
    );
  }
}

class PricingCard extends StatelessWidget {
  const PricingCard({
    Key? key,
    required this.title,
    required this.price,
    required this.text,
    required this.mainColor,
    required this.columnNum,
  }) : super(key: key);

  final Widget title;
  final Widget price;
  final Widget text;
  final Color mainColor;
  final int columnNum;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: mainColor, width: 1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
        child: Column(
          children: [
            title,
            const SizedBox(
              height: defaultPadding * 1.5,
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              color: mainColor,
            ),
            const SizedBox(
              height: defaultPadding * 1.5,
            ),
            price,
            const SizedBox(
              height: defaultPadding * 1.5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding * 3),
              child: Column(
                children: [
                  Container(
                    height: 0.25,
                    width: double.infinity,
                    color: mainColor,
                  ),
                  const SizedBox(
                    height: defaultPadding * 3,
                  ),
                  text,
                  const SizedBox(
                    height: defaultPadding * 3,
                  ),
                  Container(
                    height: 0.25,
                    width: double.infinity,
                    color: mainColor,
                  ),
                  const SizedBox(
                    height: defaultPadding * 1.5,
                  ),
                  Container(
                    height: 225,
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      final double width = columnNum > 6
                          ? constraints.maxWidth * 0.45
                          : constraints.maxWidth * 0.9;
                      return Wrap(
                        direction: Axis.vertical,
                        children: [
                          for (int idx = 0; idx < columnNum; idx++)
                            PriceInfoTile(
                              width: width,
                              iconColor: mainColor,
                            ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(
                    height: defaultPadding * 1.5,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(mainColor),
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: defaultPadding * 1),
                      child: Text(
                        "선택하기",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 0.5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriceInfoTile extends StatelessWidget {
  const PriceInfoTile({
    Key? key,
    required this.width,
    required this.iconColor,
  }) : super(key: key);

  final double width;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 35,
      child: ListTile(
        leading: Icon(
          Icons.check,
          color: iconColor,
          size: 20,
        ),
        horizontalTitleGap: 0,
        title: Text(
          "미친 혜택 가득",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
