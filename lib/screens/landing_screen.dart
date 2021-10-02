import 'package:ai_counseling_platform/constants.dart';
import 'package:ai_counseling_platform/controllers/scrollable_appbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/above_the_fold.dart';
import 'components/footer.dart';
import 'components/partnes.dart';
import 'components/platform_info.dart';
import 'components/rounded_button.dart';
import 'components/sales_point_item.dart';
import 'components/sales_points.dart';
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
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                const AboveTheFold(),
                const PlatformInfo(),
                const SizedBox(
                  height: 100,
                ),
                const SalesPoints(),
                const SizedBox(
                  height: 100,
                ),
                const Partners(),
                const Footer()
              ]),
            )
          ],
        ),
      ),
    );
  }
}
