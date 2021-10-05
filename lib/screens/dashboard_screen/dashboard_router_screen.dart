import 'package:ai_counseling_platform/controllers/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../responsive.dart';
import 'components/side_menu.dart';

class DashboardRouterScreen extends StatelessWidget {
  const DashboardRouterScreen({Key? key}) : super(key: key);

  static String id = "dashboardRouterScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldkey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) Expanded(child: SideMenu()),
            Expanded(
              flex: 5,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
