class LineChartMetaData {
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final String Function(double) leftTitle;
  final String Function(double) bottomTitle;

  LineChartMetaData({
    required this.maxX,
    required this.maxY,
    required this.minX,
    required this.minY,
    required this.leftTitle,
    required this.bottomTitle,
  });
}
