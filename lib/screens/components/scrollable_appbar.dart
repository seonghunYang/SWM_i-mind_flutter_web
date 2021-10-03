import 'package:ai_counseling_platform/controllers/scrollable_appbar_controller.dart';
import 'package:ai_counseling_platform/screens/custom_screen/custom_screen.dart';
import 'package:ai_counseling_platform/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class ScrollableAppbar extends StatelessWidget with PreferredSizeWidget {
  const ScrollableAppbar({
    Key? key,
    required this.transparent,
  }) : super(key: key);

  final bool transparent;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  TextStyle? getTextStyleWithBackgroundColor(
          BuildContext context, bool isTransparent) =>
      isTransparent
          ? Theme.of(context).textTheme.subtitle2
          : Theme.of(context).textTheme.subtitle1;

  @override
  Widget build(BuildContext context) {
    final bool isTransparent;
    if (transparent) {
      isTransparent = context.watch<ScrollableAppbarController>().isTransparent;
    } else {
      isTransparent = false;
    }
    TextStyle? textStyle =
        getTextStyleWithBackgroundColor(context, isTransparent);
    return AppBar(
      elevation: isTransparent ? 0 : 0.5,
      backgroundColor: isTransparent ? Colors.transparent : Colors.white,
      flexibleSpace: isTransparent
          ? Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            )
          : null,
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.all(defaultPadding * 1.5),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, LandingScreen.id);
          },
          child: const Image(
            image: AssetImage("assets/images/logo.png"),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, CustomScreen.id);
            },
            child: Text(
              "서비스 소개",
              style: textStyle,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "이용 요금",
              style: textStyle,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "회사 소개",
              style: textStyle,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        InkWell(
          child: Center(
            child: Text(
              "로그인",
              style: textStyle!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: defaultPadding),
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 3),
          child: Text(
            "무료 회원가입",
            style: TextStyle(
              color: isTransparent ? kMainColor : Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          decoration: BoxDecoration(
              color: isTransparent ? Colors.white : kMainColor,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
        const SizedBox(
          width: 30,
        ),
      ],
    );
  }
}