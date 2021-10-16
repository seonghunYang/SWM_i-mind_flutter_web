import 'package:flutter/material.dart';

class CounselingRecordCreateAlertDialog extends StatefulWidget {
  const CounselingRecordCreateAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CounselingRecordCreateAlertDialog> createState() =>
      _CounselingRecordCreateAlertDialog();
}

class _CounselingRecordCreateAlertDialog
    extends State<CounselingRecordCreateAlertDialog> {
  TextEditingController dateController = TextEditingController();
  String selectedCategory = "";

  FilePickerResult? selectedVideo;

  void changeCategory(dynamic newValue) {
    setState(() {
      selectedCategory = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "상담 기록 추가",
        style: Theme.of(context).textTheme.headline4,
      ),
      content: Container(
        width: 550,
        height: 200,
        child: Form(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: UserTextFormField(
                      textEditingController: dateController,
                      text: "생년월일",
                      onlyNumber: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dateController.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding * 3,
                  ),
                  Expanded(
                    child: UserTextFormField(
                      text: "카테고리",
                      dropDownMenuOnChanged: changeCategory,
                      isDropDownButton: true,
                      dropDownMenuItems: [
                        DropdownMenuItem(
                          child: Text("놀이영상분석"),
                          value: "놀이영상분석",
                        ),
                      ],
                    ),
                  )
                ],
              ),
              if (selectedCategory == "놀이영상분석")
                Expanded(
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          selectedVideo = await FilePicker.platform.pickFiles();
                          setState(() {});
                          // if (selectedVideo != null) {
                          //   File file = File(
                          //       selectedVideo.files, "${selectedVideo.files.single.name}");
                          // } else {
                          //   // User canceled the picker
                          // }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: defaultPadding * 2.5,
                                vertical: defaultPadding * 2.5),
                          ),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.upload_file),
                            SizedBox(
                              width: defaultPadding,
                            ),
                            Text(
                              "동영상 업로드",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
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
          onPressed: () {
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
