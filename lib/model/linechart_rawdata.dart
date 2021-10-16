import 'dart:ui';

class LineChartRawDataSet {
  final String title;
  final Color color;
  final List<List<double>> values;

  LineChartRawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });
}
