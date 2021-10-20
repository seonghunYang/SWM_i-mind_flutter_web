class CustomerDetail {
  final List<Map<String, String>> indicatorRecordList;
  final Map<String, int> recentIndicator;
  final List avgIndicator;
  final List counselingRecordList;

  CustomerDetail({
    required this.indicatorRecordList,
    required this.recentIndicator,
    required this.avgIndicator,
    required this.counselingRecordList,
  });
}
