import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

class UserTextFormField extends StatelessWidget {
  const UserTextFormField({
    Key? key,
    required this.text,
    this.textEditingController,
    this.maxline = 1,
    this.onlyNumber = false,
    this.isDropDownButton = false,
    this.dropDownMenuItems = const [],
    this.dropDownMenuOnChanged,
    this.hintMessage = "",
    this.onTap,
  }) : super(key: key);
  final String hintMessage;

  final bool onlyNumber;
  final String text;
  final TextEditingController? textEditingController;
  final bool isDropDownButton;
  final List<DropdownMenuItem> dropDownMenuItems;
  final void Function(dynamic)? dropDownMenuOnChanged;
  final int maxline;
  final void Function()? onTap;

  Widget setTextFormField() {
    if (onlyNumber) {
      return TextFormField(
        controller: textEditingController,
        validator: (value) {
          return value!.isNotEmpty ? null : "항목을 입력해주세요";
        },
        onTap: onTap,
        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          hintText: hintMessage,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding * 1.75),
          border: OutlineInputBorder(),
        ),
      );
    } else {
      return TextFormField(
        maxLines: maxline,
        controller: textEditingController,
        validator: (value) {
          return value!.isNotEmpty ? null : "항목을 입력해주세요";
        },
        decoration: InputDecoration(
          hintText: hintMessage,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding * 1.75),
          border: OutlineInputBorder(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: defaultPadding),
        if (!isDropDownButton) setTextFormField(),
        if (isDropDownButton)
          DropdownButtonFormField(
            validator: (dynamic value) {
              return value == null ? "항목을 입력해주세요" : null;
            },
            items: dropDownMenuItems,
            onChanged: dropDownMenuOnChanged,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding * 1.75),
              border: OutlineInputBorder(),
            ),
          )
      ],
    );
  }
}
