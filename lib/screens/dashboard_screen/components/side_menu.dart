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
      elevation: 8.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(
                ('assets/images/ipdi75/logo.png'),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.red, width: 0.1),
                ),
              ),
            ),
            DrawerItem(
              title: 'Home',
              svgSrc: "assets/icons/homepage.svg",
              press: () {},
            ),
            DrawerItem(
              title: 'Dashboard',
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {},
            ),
            DrawerItem(
              title: 'Manage',
              svgSrc: "assets/icons/menu_doc.svg",
              press: () {},
            ),
            DrawerItem(
              title: 'Store',
              svgSrc: "assets/icons/menu_store.svg",
              press: () {},
            ),
            DrawerItem(
              title: 'Notification',
              svgSrc: "assets/icons/menu_notification.svg",
              press: () {},
            ),
            DrawerItem(
              title: 'Profile',
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {},
            ),
            DrawerItem(
              title: 'Settings',
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {},
            ),
          ],
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
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: SvgPicture.asset(
          svgSrc,
          color: Colors.red,
          height: 16,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.red,
          ),
        ));
  }
}
