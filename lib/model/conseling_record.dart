class CounselingRecord {
  CounselingRecord({
    required this.counselingId,
    required this.customerId,
    required this.childName,
    required this.counselor,
    required this.counselingStatus,
    required this.category,
    required this.date,
    required this.realId,
  });
  final String counselingId;
  final String customerId;
  final String childName;
  final String counselor;
  String counselingStatus;
  final String category;
  final String date;
  final String realId;
}
// 상태, 분석중, 분석완료, 상담 완료
