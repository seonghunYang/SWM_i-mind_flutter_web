import 'package:ai_counseling_platform/screens/components/scrollable_appbar.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/pretty_padding_button.dart';
import 'components/service_info.dart';

class CustomScreen extends StatelessWidget {
  const CustomScreen({Key? key}) : super(key: key);

  static const id = "customScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollableAppbar(
        transparent: false,
      ),
      body: Container(
        color: const Color(0xfff7f8fc),
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding * 15, vertical: defaultPadding * 3),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ServiceInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
