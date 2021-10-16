import 'package:ai_counseling_platform/controllers/menu_controller.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/screens/dashboard_counseling_record_manage_screen.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/screens/dashboard_customer_manage_screen.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/screens/dashboard_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../../utils/responsive.dart';
import 'components/side_menu.dart';

class DashboardRouterScreen extends StatelessWidget {
  const DashboardRouterScreen({Key? key}) : super(key: key);

  static String id = "dashboardRouterScreen";

  Widget getDashboardScreen(int index) {
    switch (index) {
      case 0:
        return const DashboardHomeScreen();
      case 1:
        return const DashboardCustomerManageScreen();
      case 2:
        return const DashboardCounselingRecordManageScreen();
      default:
        return const DashboardHomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldkey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) Expanded(child: SideMenu()),
            Consumer<MenuController>(builder: (context, menuController, _) {
              return Expanded(
                flex: 5,
                child: getDashboardScreen(menuController.selectedMenuIndex),
              );
            }),
          ],
        ),
      ),
    );
  }
}
