import 'package:ai_counseling_platform/screens/components/footer.dart';
import 'package:ai_counseling_platform/screens/components/scrollable_appbar.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/custom_stepper.dart';
import 'components/service_info.dart';

import 'components/stepper_remote_buttons.dart';

class CustomScreen extends StatefulWidget {
  const CustomScreen({Key? key}) : super(key: key);

  static const id = "customScreen";

  @override
  State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("a");
    return Scaffold(
      appBar: const ScrollableAppbar(
        transparent: false,
        buttonColor: kSelectedContainerColor,
      ),
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                const ServiceInfo(),
                const CustomStepper(),
                StepperRemoteButtons(
                  scrollController: _scrollController,
                ),
                const Footer(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
