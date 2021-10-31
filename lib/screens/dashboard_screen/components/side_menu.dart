import 'package:ai_counseling_platform/constants.dart';
import 'package:ai_counseling_platform/controllers/menu_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: Container(
        decoration: BoxDecoration(
            color: kDashboardMenuColor,
            border: Border(right: BorderSide(color: Colors.grey, width: 0.3))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                margin: EdgeInsets.only(
                    left: defaultPadding * 1,
                    right: defaultPadding * 1,
                    bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding,
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: defaultPadding,
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/images/growingmom_logo.png',
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: kDashboardMenuColor, width: 1),
                  ),
                ),
              ),
              SizedBox(
                height: defaultPadding * 1.5,
              ),
              DrawerItem(
                title: 'Home',
                svgSrc: "assets/icons/homepage.svg",
                index: 0,
              ),
              SizedBox(
                height: defaultPadding * 1.5,
              ),
              DrawerItem(
                title: '고객 관리',
                svgSrc: "assets/icons/menu_dashbord.svg",
                index: 1,
              ),
              SizedBox(
                height: defaultPadding * 1.5,
              ),
              DrawerItem(
                title: '상담내역 관리',
                svgSrc: "assets/icons/menu_doc.svg",
                index: 2,
              ),
              SizedBox(
                height: defaultPadding * 1.5,
              ),
              DrawerItem(
                title: '상담일지 조회',
                svgSrc: "assets/icons/menu_tran.svg",
                index: 3,
              ),
              SizedBox(
                height: defaultPadding * 1.5,
              ),
              DrawerItem(
                title: '상담사 조회',
                svgSrc: "assets/icons/menu_profile.svg",
                index: 4,
              ),
              SizedBox(
                height: defaultPadding * 1.5,
              ),
              DrawerItem(
                title: '설정',
                svgSrc: "assets/icons/menu_setting.svg",
                index: 5,
              ),
              SizedBox(
                height: defaultPadding * 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.index,
  }) : super(key: key);

  final String title, svgSrc;
  final int index;

  @override
  Widget build(BuildContext context) {
    final MenuController menuController = context.watch<MenuController>();
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 4),
          width: menuController.selectedMenuIndex == index ? 3 : 0,
          decoration: const BoxDecoration(
              color: kSelectedDashboardTextColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          height: 36,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
              maxWidth: 200, maxHeight: 100, minHeight: 48),
          child: ListTile(
              onTap: () {
                menuController.updateMenuIndex(index);
              },
              horizontalTitleGap: -10,
              contentPadding: EdgeInsets.only(left: defaultPadding * 4),
              leading: SvgPicture.asset(
                svgSrc,
                color: menuController.selectedMenuIndex == index
                    ? kSelectedDashboardTextColor
                    : Colors.grey,
                height: 14,
              ),
              title: Text(
                title,
                style: TextStyle(
                    color: menuController.selectedMenuIndex == index
                        ? kSelectedDashboardTextColor
                        : kDashboardTextColor,
                    fontSize: 14,
                    fontWeight: menuController.selectedMenuIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal),
              )),
        ),
      ],
    );
  }
}
