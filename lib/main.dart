import 'package:ai_counseling_platform/constants.dart';
import 'package:ai_counseling_platform/controllers/chips_controller.dart';
import 'package:ai_counseling_platform/controllers/custom_logic_controller.dart';
import 'package:ai_counseling_platform/controllers/menu_controller.dart';
import 'package:ai_counseling_platform/controllers/scrollable_position_controller.dart';
import 'package:ai_counseling_platform/controllers/slider_controller.dart';
import 'package:ai_counseling_platform/controllers/stepper_controller.dart';
import 'package:ai_counseling_platform/controllers/user_controller.dart';
import 'package:ai_counseling_platform/screens/custom_screen/custom_screen.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/dashboard_router_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/counseling_record_controller.dart';
import 'controllers/customer_controller.dart';
import 'screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ScrollPositionController(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserController(),
          ),
          ChangeNotifierProvider(
            create: (context) => StepperController(),
          ),
          ChangeNotifierProvider(
            create: (context) => SliderController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ChipsController(),
          ),
          ChangeNotifierProvider(
            create: (context) => CustomLogicController(),
          ),
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
          ChangeNotifierProvider(
            create: (context) => CustomerController(),
          ),
          ChangeNotifierProvider(
            create: (context) => CounselingRecordController(),
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ai counseling platform',
            theme: ThemeData(
              textTheme: kTextTheme.apply(
                fontFamily: "Noto_sans_kr",
              ),
            ),
            initialRoute: LandingScreen.id,
            routes: {
              LandingScreen.id: (context) => const LandingScreen(),
              CustomScreen.id: (context) => const CustomScreen(),
              DashboardRouterScreen.id: (context) =>
                  const DashboardRouterScreen(),
            },
          );
        });
  }
}
