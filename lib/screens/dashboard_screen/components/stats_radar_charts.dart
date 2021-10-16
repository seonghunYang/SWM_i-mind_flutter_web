import 'package:ai_counseling_platform/model/radarchart_rawdata.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart_indicator.dart';

class StatsRadarChart extends StatefulWidget {
  const StatsRadarChart({
    Key? key,
    required this.rawDatasets,
    required this.indicators,
  }) : super(key: key);

  final List<RadarChartRawDataSet> rawDatasets;
  final List<ChartIndicator> indicators;

  @override
  State<StatsRadarChart> createState() => _StatsRadarChartState();
}

class _StatsRadarChartState extends State<StatsRadarChart> {
  int selectedDataSetIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.indicators),
        SizedBox(
          height: defaultPadding * 2,
        ),
        Expanded(
          child: RadarChart(
            RadarChartData(
              dataSets: showingDataSets(),
              radarBackgroundColor: Colors.transparent,
              borderData: FlBorderData(show: false),
              radarBorderData: const BorderSide(color: Colors.transparent),
              titlePositionPercentageOffset: 0.2,
              titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
              getTitle: (index) {
                switch (index) {
                  case 0:
                    return '민감도';
                  case 1:
                    return '지속성/몰입도';
                  case 2:
                    return '주도성';
                  case 3:
                    return '즐거움';
                  case 4:
                    return '반복하기';
                  default:
                    return '';
                }
              },
              tickCount: 1,
              ticksTextStyle:
                  const TextStyle(color: Colors.transparent, fontSize: 14),
              tickBorderData: const BorderSide(color: Colors.transparent),
              gridBorderData: const BorderSide(color: Colors.black38, width: 2),
            ),
            swapAnimationDuration: const Duration(milliseconds: 400),
          ),
        ),
      ],
    );
  }

  List<RadarDataSet> showingDataSets() {
    return widget.rawDatasets.asMap().entries.map((entry) {
      var index = entry.key;
      var rawDataSet = entry.value;
      return RadarDataSet(
        fillColor: rawDataSet.title == "mean"
            ? rawDataSet.color.withOpacity(0.10)
            : rawDataSet.color.withOpacity(0.20),
        borderColor: rawDataSet.color,
        entryRadius: 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: rawDataSet.title == "mean" ? 1 : 1.5,
      );
    }).toList();
  }
}
