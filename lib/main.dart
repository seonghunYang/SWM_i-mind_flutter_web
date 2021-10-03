import 'package:ai_counseling_platform/constants.dart';
import 'package:ai_counseling_platform/controllers/scrollable_appbar_controller.dart';
import 'package:ai_counseling_platform/controllers/user_controller.dart';
import 'package:ai_counseling_platform/screens/custom_screen/custom_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            create: (context) => ScrollableAppbarController(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserController(),
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
              LandingScreen.id: (context) => LandingScreen(),
              CustomScreen.id: (context) => CustomScreen(),
            },
          );
        });
  }
}
