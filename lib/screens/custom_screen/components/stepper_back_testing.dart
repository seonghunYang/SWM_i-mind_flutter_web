import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../../../constants.dart';

class StepperBackTesting extends StatelessWidget {
  const StepperBackTesting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "데모영상 테스트",
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: defaultPadding * 3,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("- 데모영상은 한번 업로드 하시면 변경이 불가능하며, 조합한 분석지표는 변경이 가능합니다.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                )),
            Text("- 분석지표와 결과를 비교해가면서 우리 센터에 맞는 분석지표를 조합할 수 있습니다.",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    height: 2)),
            Text("- 데모영상은 일주일간 보관되며, 이후 자동 삭제됩니다.",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    height: 2)),
          ],
        ),
        SizedBox(
          height: defaultPadding * 3,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding * 10),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1. 데모 테스트 영상을 선택하세요.",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: defaultPadding * 3,
              ),
              FileButton(),
              SizedBox(
                height: defaultPadding * 3,
              ),
              TextButton(onPressed: () {}, child: Text("분석 수행")),
              SizedBox(
                height: defaultPadding * 5,
              ),
              Text(
                "2. 분석결과 확인",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Container(
          height: 100,
        ),
      ],
    );
  }
}

class FileButton extends StatefulWidget {
  const FileButton({Key? key}) : super(key: key);

  @override
  _FileButtonState createState() => _FileButtonState();
}

class _FileButtonState extends State<FileButton> {
  String selectedFileName = "";
  void webFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();

      setState(() {
        selectedFileName = file.name;
      });

      reader.onLoadEnd.listen((e) {
        // print(reader.result);
        // _handleResult(reader.result);
        // print(reader.result);
      });
      reader.readAsDataUrl(file);
    });
  }

  // void _handleResult(Object? result) {
  //     _bytesData = Base64Decoder().convert(result.toString().split(",").last);
  //     _selectedFile = _bytesData;
  // }
  //
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () async {
            webFilePicker();
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
            mainAxisSize: MainAxisSize.min,
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
        SizedBox(
          width: defaultPadding,
        ),
        Text(selectedFileName, style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}
