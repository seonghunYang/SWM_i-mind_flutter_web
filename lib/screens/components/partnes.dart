import 'package:flutter/material.dart';

import '../../constants.dart';

class Partners extends StatelessWidget {
  const Partners({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: defaultPadding * 5, bottom: defaultPadding * 7),
      color: const Color(0xfff5f5f5),
      child: Column(
        children: [
          Text(
            "Partners",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: defaultPadding * 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                height: 50,
                image: AssetImage("assets/images/swm_logo.png"),
              ),
              SizedBox(
                width: defaultPadding,
              ),
              Image(
                height: 50,
                image: AssetImage("assets/images/growingmom_logo.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
