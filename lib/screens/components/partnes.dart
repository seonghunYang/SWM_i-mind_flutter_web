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
          top: defaultPadding * 4, bottom: defaultPadding * 7),
      color: Colors.grey.withOpacity(0.05),
      child: Column(
        children: [
          Text(
            "Partners",
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: defaultPadding * 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                height: 50,
                image: AssetImage("assets/images/swm_logo.png"),
              ),
              SizedBox(
                width: defaultPadding * 6,
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
