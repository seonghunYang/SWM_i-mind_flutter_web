import 'package:flutter/material.dart';
import 'components/scrollable_appbar.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ScrollableAppbar(isTransparent: true),
      body: Container(),
    );
  }
}
