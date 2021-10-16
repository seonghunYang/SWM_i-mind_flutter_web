class CounselingRecord {
  CounselingRecord({
    required this.counselingId,
    required this.customerId,
    required this.childName,
    required this.counselor,
    required this.counselingStatus,
    required this.category,
    required this.date,
  });
  final String counselingId;
  final String customerId;
  final String childName;
  final String counselor;
  final String counselingStatus;
  final String category;
  final String date;
}
// 상태, 분석중, 분석완료, 상담 완료
