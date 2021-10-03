import 'package:flutter/material.dart';

import '../../constants.dart';

class SalesPointItem extends StatelessWidget {
  const SalesPointItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.tag,
  }) : super(key: key);

  final Widget title;
  final Widget subTitle;
  final Widget image;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: defaultPadding * 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: kMainColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tag,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                title,
                const SizedBox(
                  height: defaultPadding * 2,
                ),
                subTitle,
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 200,
            padding: const EdgeInsets.only(right: defaultPadding * 15),
            child: FittedBox(
              child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 1, minHeight: 1),
                  child: image),
            ),
          ),
        ),
      ],
    );
  }
}
