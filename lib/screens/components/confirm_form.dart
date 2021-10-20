import 'package:ai_counseling_platform/controllers/user_controller.dart';
import 'package:ai_counseling_platform/screens/components/form_submit_button.dart';
import 'package:ai_counseling_platform/screens/components/user_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../constants.dart';
import '../landing_screen.dart';

class ConfirmForm extends StatefulWidget {
  ConfirmForm({
    Key? key,
    required this.emailController,
    required this.clientIdController,
  }) : super(key: key);

  TextEditingController emailController;
  TextEditingController clientIdController;

  @override
  _ConfirmFormState createState() => _ConfirmFormState();
}

class _ConfirmFormState extends State<ConfirmForm> {
  TextEditingController confirmCodeController = TextEditingController();

  bool isDisable = false;

  @override
  Widget build(BuildContext context) {
    final UserController userController = context.read<UserController>();
    return Column(
      children: [
        SizedBox(
          height: defaultPadding * 4,
        ),
        Text(
          "이메일 인증",
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: defaultPadding * 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("-작성해주신 이메일 주소에서 메일을 확인하신 가입확인 코드를 입력해주세요",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                )),
            Text("-메일 인증 관련 보안 이슈가 있다면, support@i-mind.co.kr로 연락 부탁드립니다.",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    height: 2)),
          ],
        ),
        SizedBox(
          height: defaultPadding * 5,
        ),
        Expanded(
          child: UserFormField(
            textEditingController: confirmCodeController,
            title: "가입확인 코드",
            hintText: "작성한 이메일에서 가입확인 코드를 입력하세요",
          ),
        ),
        SizedBox(
          height: defaultPadding * 5,
        ),
        FormSubmitButton(
            onPressed: () async {
              String confirmCode = confirmCodeController.value.text;
              String email = widget.emailController.value.text;
              String clientId = widget.clientIdController.value.text;

              var response = await userController.confirm(
                  email: email, confirmCode: confirmCode, clientId: clientId);

              if (response == true) {
                Navigator.pushNamed(context, LandingScreen.id);
                ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                  padding: EdgeInsets.all(defaultPadding * 0.5),
                  content: Text(
                    '회원가입이 완료되었습니다.',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  leading: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                  ),
                  backgroundColor: kSelectedContainerColor,
                  actions: <Widget>[
                    TextButton(
                      child: Text("로그인 하기"),
                      onPressed: () {},
                    )
                  ],
                ));
                Future.delayed(
                    Duration(seconds: 5),
                    () => ScaffoldMessenger.of(context)
                        .hideCurrentMaterialBanner());
              } else {}
            },
            title: "인증하기"),
        SizedBox(
          height: defaultPadding * 5,
        ),
      ],
    );
  }
}
