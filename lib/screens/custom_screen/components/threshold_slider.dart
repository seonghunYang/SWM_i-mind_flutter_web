import 'package:ai_counseling_platform/controllers/slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../constants.dart';

class ThresholdSlider extends StatelessWidget {
  const ThresholdSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SliderController>(builder: (context, sliderController, _) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 20),
        child: SfSlider(
          value: sliderController.value,
          min: 0.0,
          max: 100.0,
          interval: 20,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          onChanged: (value) {
            sliderController.updateValue(value);
          },
        ),
      );
    });
  }
}
