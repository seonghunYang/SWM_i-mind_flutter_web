class Customer {
  Customer({
    required this.id,
    required this.parentName,
    required this.childName,
    required this.childAge,
    required this.parentAge,
    required this.childGender,
    required this.parentRelation,
    required this.email,
    required this.special,
  });
  final String id;
  final String parentName;
  final String childName;
  final int childAge;
  final int parentAge;
  final String childGender;
  final String parentRelation;
  final String email;
  final String special;
}
