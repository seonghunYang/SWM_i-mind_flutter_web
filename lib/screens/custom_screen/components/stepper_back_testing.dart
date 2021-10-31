import 'package:ai_counseling_platform/controllers/backtesting_controller.dart';
import 'package:ai_counseling_platform/controllers/stepper_controller.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/pretty_padding_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'dart:html' as html;
import '../../../constants.dart';
import 'demo_custom_record_page.dart';
import '../demo_report_screen.dart';

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
          height: defaultPadding * 6,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding * 10),
          alignment: Alignment.centerLeft,
          child: DemoTestingContainer(),
        ),
        // DemoCustomRecordPage(),
        Container(
          height: 40,
        ),
      ],
    );
  }
}

class DemoTestingContainer extends StatefulWidget {
  const DemoTestingContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<DemoTestingContainer> createState() => _DemoTestingContainerState();
}

class _DemoTestingContainerState extends State<DemoTestingContainer> {
  @override
  Widget build(BuildContext context) {
    BacktestingController backtestingController =
        context.watch<BacktestingController>();
    bool stepTwo = backtestingController.stepTwo;
    bool stepTwoLoading = backtestingController.stepTwoLoading;
    bool stepThree = backtestingController.stepThree;
    bool isShowResult = backtestingController.isShowResult;
    return Column(
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
        SizedBox(),
        FileButton(
          backtestingController: backtestingController,
          onTap: () {
            backtestingController.updateStepTwo();
          },
        ),
        SizedBox(
          height: defaultPadding * 5,
        ),
        if (stepTwo)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: defaultPadding * 5,
              ),
              Text(
                "2. 선택하신 영상에 지표 분석을 수행하시겠습니까?",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: defaultPadding * 3,
              ),
              stepTwoLoading
                  ? Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          width: defaultPadding * 3,
                        ),
                        Text("분석중입니다. 완료시 알람을 통해 알려드립니다.",
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    )
                  : TextButton(
                      onPressed: () {
                        backtestingController.updateStepTwoLoading();
                        if (stepThree) {
                          backtestingController.updateStepThree();
                        }
                        Future.delayed(Duration(seconds: 15), () {
                          backtestingController.updateStepTwoLoading();
                          backtestingController.updateStepThree();
                          if (isShowResult == true) {
                            backtestingController.updateShowResult();
                          }
                        });
                      },
                      child: Text("분석 수행")),
              SizedBox(
                height: defaultPadding * 5,
              ),
            ],
          ),
        if (stepThree)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: defaultPadding * 3,
              ),
              Text(
                "3. 분석 결과를 확인하세요!",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: defaultPadding * 3,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, DemoReportScreen.id);
                    backtestingController.updateShowResult();
                  },
                  child: Text("결과 확인하기")),
              SizedBox(
                height: defaultPadding * 6,
              ),
            ],
          ),
        if (isShowResult)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer<StepperController>(
                  builder: (context, stepperController, _) {
                return PrettyPaddingButton(
                  backgroundColor: kSelectedContainerColor,
                  text: "이 옵션으로 문의하기",
                  onPressed: () {
                    stepperController.plusCurrentNumberKey();
                  },
                );
              }),
            ],
          )

        // Text(
        //   "2. 분석결과 확인",
        //   style: Theme.of(context)
        //       .textTheme
        //       .headline4!
        //       .copyWith(fontWeight: FontWeight.w500),
        // ),
      ],
    );
  }
}

class FileButton extends StatefulWidget {
  const FileButton(
      {Key? key, required this.onTap, required this.backtestingController})
      : super(key: key);
  final void Function() onTap;
  final BacktestingController backtestingController;

  @override
  _FileButtonState createState() => _FileButtonState();
}

class _FileButtonState extends State<FileButton> {
  void webFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      widget.backtestingController.updateLoading();
      Future.delayed(Duration(seconds: 2), () {
        widget.onTap();
        widget.backtestingController.updateLoading();
        final files = uploadInput.files;
        final file = files![0];

        widget.backtestingController.updateFileName(file.name);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: widget.backtestingController.isLoading ||
                  widget.backtestingController.stepThree ||
                  widget.backtestingController.stepTwoLoading
              ? null
              : () async {
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
          width: defaultPadding * 2,
        ),
        Text(widget.backtestingController.selectedFileName,
            style: Theme.of(context).textTheme.subtitle1),
        widget.backtestingController.isLoading
            ? CircularProgressIndicator()
            : SizedBox()
      ],
    );
  }
}
