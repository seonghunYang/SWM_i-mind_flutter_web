import 'package:ai_counseling_platform/controllers/slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../constants.dart';

class ThresholdSlider extends StatefulWidget {
  const ThresholdSlider({
    Key? key,
    required this.labelFormatterCallback,
    required this.tooltipTextFormatterCallback,
    this.defaultValue = 4,
  }) : super(key: key);
  final int defaultValue;

  final String Function(dynamic, String)? labelFormatterCallback;
  final String Function(dynamic, String)? tooltipTextFormatterCallback;

  @override
  State<ThresholdSlider> createState() => _ThresholdSliderState();
}

class _ThresholdSliderState extends State<ThresholdSlider> {
  late SliderController sliderController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sliderController = SliderController(value: widget.defaultValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 20),
      child: SfSlider(
        tooltipShape: SfPaddleTooltipShape(),
        value: sliderController.value,
        min: 1,
        max: 5,
        interval: 1,
        showTicks: true,
        showLabels: true,
        enableTooltip: true,
        minorTicksPerInterval: 1,
        onChanged: (value) {
          sliderController.updateValue(value);
          setState(() {});
        },
        labelFormatterCallback: widget.labelFormatterCallback,
        //     (dynamic value, String formattedText) {
        //   switch (value) {
        //     case 1:
        //       return "매우낮음";
        //     case 2:
        //       return "낮음";
        //     case 3:
        //       return "보통";
        //     case 4:
        //       return "높음*";
        //     case 5:
        //       return "메우높음";
        //     default:
        //       return "낮음";
        //   }
        // },
        tooltipTextFormatterCallback: (dynamic value, String formattedText) {
          switch (value) {
            case 1:
              return "인식강도 매우 낮음, 가능성이 있는 모든 행동 인식";
            case 2:
              return "인식강도 낮음, 명확하게 구별되지 않은 유사한 행동도 식별 ";
            case 3:
              return "보통, 맥락에 맞는 수준의 행동 인식";
            case 4:
              return "높음, 사람이 판단하는 것과 가장 유사한 정도로 구분력이 있는 행동 인식";
            case 5:
              return "메우높음, 명확하게 인식되는 엄격한 수준의 행동 인식";
            default:
              return "낮음";
          }
        },
      ),
    );
  }
}
