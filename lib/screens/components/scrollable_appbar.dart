import 'package:flutter/material.dart';

import '../../constants.dart';

class ScrollableAppbar extends StatelessWidget with PreferredSizeWidget {
  const ScrollableAppbar({
    Key? key,
    required this.isTransparent,
  }) : super(key: key);

  final bool isTransparent;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: isTransparent ? Colors.transparent : Colors.white,
      flexibleSpace: isTransparent
          ? Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.grey,
                    Colors.transparent,
                  ])),
            )
          : null,
      leadingWidth: 75,
      leading: const Padding(
        padding: EdgeInsets.all(defaultPadding * 0.75),
        child: Image(
          image: NetworkImage(
              "https://s3-ap-northeast-2.amazonaws.com/growingmather/images/person_yellow@3x.8e62dd831bb5707814aa44a9d1ab69e2.png"),
        ),
      ),
      title: Image(
        width: 157,
        height: 26,
        image: NetworkImage(!isTransparent
            ? "https://s3-ap-northeast-2.amazonaws.com/growingmather/images/logo_green@3x.b87d1236be9b9c2b1fa1967ea5332ea0.png"
            : "https://s3-ap-northeast-2.amazonaws.com/growingmather/images/logo_horizontal_white_fill@2x.8378c68df7747c9b81b3dbd3311cc3d7.png"),
      ),
      centerTitle: true,
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black54,
              )),
        )
      ],
    );
  }
}
