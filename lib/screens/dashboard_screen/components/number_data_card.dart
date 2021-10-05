import 'package:flutter/material.dart';

import '../../../constants.dart';

class NumberDataCard extends StatelessWidget {
  const NumberDataCard({
    Key? key,
    required this.title,
    required this.number,
    required this.icon,
    required this.colors,
  }) : super(key: key);
  final String title;
  final String number;
  final Icon icon;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black38,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding * 2, vertical: defaultPadding),
              child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                          colors: colors,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                    child: icon,
                  )),
            ),
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.black54),
                ),
                Text(
                  number,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
