import 'package:ai_counseling_platform/controllers/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../../constants.dart';
import 'user_text_formfield.dart';
import 'package:intl/intl.dart';

class UserCreateAlertDialog extends StatefulWidget {
  const UserCreateAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<UserCreateAlertDialog> createState() => _UserCreateAlertDialogState();
}

class _UserCreateAlertDialogState extends State<UserCreateAlertDialog> {
  TextEditingController childNameController = TextEditingController();
  TextEditingController parentNameController = TextEditingController();
  TextEditingController childAgeController = TextEditingController();
  TextEditingController parentAgeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  String selectedChildGender = "";
  String selectedParentRelation = "";

  void changeChildGender(dynamic newValue) {
    setState(() {
      selectedChildGender = newValue;
    });
  }

  void changeParentRelation(dynamic newValue) {
    setState(() {
      selectedParentRelation = newValue;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    childNameController.dispose();
    parentNameController.dispose();
    childAgeController.dispose();
    parentAgeController.dispose();
    emailController.dispose();
    remarkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "신규 고객 등록",
        style: Theme.of(context).textTheme.headline4,
      ),
      content: Container(
        width: 550,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: UserTextFormField(
                  textEditingController: childNameController,
                  text: "아이이름",
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: UserTextFormField(
                        textEditingController: childAgeController,
                        text: "아이 생년월일",
                        onlyNumber: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialEntryMode: DatePickerEntryMode.calendar,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              childAgeController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding * 3,
                    ),
                    Expanded(
                      child: UserTextFormField(
                        text: "아이성별",
                        dropDownMenuOnChanged: changeChildGender,
                        isDropDownButton: true,
                        dropDownMenuItems: [
                          DropdownMenuItem(
                            child: Text("남아"),
                            value: "남아",
                          ),
                          DropdownMenuItem(
                            child: Text("여아"),
                            value: "여아",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: UserTextFormField(
                        textEditingController: parentNameController,
                        text: "부모이름",
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding * 3,
                    ),
                    Expanded(
                      child: UserTextFormField(
                        text: "부모관계",
                        dropDownMenuOnChanged: changeParentRelation,
                        isDropDownButton: true,
                        dropDownMenuItems: [
                          DropdownMenuItem(
                            child: Text("엄마"),
                            value: "엄마",
                          ),
                          DropdownMenuItem(
                            child: Text("아빠"),
                            value: "아빠",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: UserTextFormField(
                        textEditingController: parentAgeController,
                        text: "부모 생년월일",
                        onlyNumber: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  1940), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              parentAgeController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding * 3,
                    ),
                    Expanded(
                      child: UserTextFormField(
                        text: "이메일",
                        textEditingController: emailController,
                      ),
                    )
                  ],
                ),
              ),
              UserTextFormField(
                text: "특이사항",
                textEditingController: remarkController,
                maxline: 6,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "취소",
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              String childName = childNameController.value.text;
              String parentName = parentNameController.value.text;
              String childAge = childAgeController.value.text;
              String parentAge = parentAgeController.value.text;
              String email = emailController.value.text;
              String special = remarkController.value.text;

              context.read<CustomerController>().createCustomer(
                  childName: childName,
                  childBirthday: childAge,
                  childGender: selectedChildGender,
                  parentName: parentName,
                  parentRelation: selectedParentRelation,
                  parentBirthday: parentAge,
                  email: email,
                  special: special);
            }

            Navigator.pop(context);
          },
          child: Text(
            "등록",
          ),
        ),
      ],
    );
  }
}
