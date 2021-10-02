import 'package:ai_counseling_platform/constants.dart';
import 'package:ai_counseling_platform/controllers/scrollable_appbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/rounded_button.dart';
import 'components/scrollable_appbar.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        context.read<ScrollableAppbarController>().getScrollController();
    return Scaffold(
      appBar: const ScrollableAppbar(),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const AboveTheFold(),
              Container(
                height: 1000,
              )
            ]),
          )
        ],
      ),
    );
  }
}
