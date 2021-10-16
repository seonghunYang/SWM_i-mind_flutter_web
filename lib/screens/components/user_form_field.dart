import 'package:ai_counseling_platform/screens/components/user_form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../constants.dart';

class UserFormField extends StatelessWidget {
  const UserFormField({
    Key? key,
    this.textEditingController,
    required this.title,
    required this.hintText,
    this.obscureText = false,
    this.isRadio = false,
    this.validator,
    this.selectedRadio,
    this.onRadioSelected,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String title;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool isRadio;
  final int? selectedRadio;
  final void Function(int, bool)? onRadioSelected;

  Widget getTextForm() {
    if (!isRadio) {
      return UserFormTextField(
          obscureText: obscureText,
          textEditingController: textEditingController,
          validator: validator,
          hintText: hintText);
    } else {
      return Padding(
        padding: EdgeInsets.only(top: defaultPadding),
        child: GroupButton(
          groupRunAlignment: GroupRunAlignment.start,
          mainGroupAlignment: MainGroupAlignment.start,
          selectedButton: selectedRadio ?? 0,
          isRadio: true,
          spacing: 10,
          onSelected: onRadioSelected!,
          buttons: ["상담센터", "상담사"],
          buttonHeight: 40,
          buttonWidth: 80,
          selectedColor: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(defaultPadding * 0.5)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "$title *",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        getTextForm(),
      ],
    );
  }
}
