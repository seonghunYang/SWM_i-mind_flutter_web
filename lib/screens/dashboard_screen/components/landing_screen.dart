import 'package:ai_counseling_platform/constants.dart';
import 'package:ai_counseling_platform/controllers/scrollable_position_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/above_the_fold.dart';
import '../../components/footer.dart';
import '../../components/partnes.dart';
import '../../components/platform_info.dart';

import '../../components/sales_points.dart';
import '../../components/scrollable_appbar.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  static const String id = "landingScreen";

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ScrollPositionController>().scrollListener(_scrollController);
    return Scaffold(
      appBar: const ScrollableAppbar(
        transparent: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          controller: _scrollController,
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
