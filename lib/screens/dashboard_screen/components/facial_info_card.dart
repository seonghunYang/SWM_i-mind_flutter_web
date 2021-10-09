import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import 'line_area_chart.dart';

class FacialInfoCard extends StatelessWidget {
  const FacialInfoCard({
    required this.title,
    required this.svgSrc,
    required this.amount,
    required this.percent,
    required this.color,
    Key? key,
  }) : super(key: key);

  final String title, svgSrc, amount;
  final double percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: defaultPadding,
          left: defaultPadding * 2,
          right: defaultPadding * 2),
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding * 0.75),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  Text(
                    "$percent%",
                    maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                height: 60,
                child: LineAreaChart(
                  bottomLineVisible: false,
                  leftLineVisible: false,
                  gridLineVisible: false,
                  areaColor: color,
                )),
          ),
        ],
      ),
    );
  }
}
