import 'package:flutter/material.dart';

import '../../constants.dart';

class UserFormTextField extends StatelessWidget {
  const UserFormTextField({
    Key? key,
    required this.obscureText,
    required this.textEditingController,
    this.validator,
    required this.hintText,
  }) : super(key: key);

  final bool obscureText;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: textEditingController,
      validator: validator ??
          (value) {
            return value!.isNotEmpty ? null : "항목을 입력해주세요";
          },
      decoration: InputDecoration(
        hintText: "$hintText",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: defaultPadding * 1.75),
      ),
    );
  }
}
