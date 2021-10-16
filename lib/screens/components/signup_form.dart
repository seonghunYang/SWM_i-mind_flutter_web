import 'package:ai_counseling_platform/controllers/user_controller.dart';
import 'package:ai_counseling_platform/screens/components/user_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../constants.dart';
import 'form_submit_button.dart';

class SignupForm extends StatefulWidget {
  SignupForm({
    Key? key,
    required this.emailController,
    required this.clientIdController,
    required this.nextStep,
    required this.selectedRadio,
    required this.onRadioSelected,
  }) : super(key: key);

  TextEditingController emailController;
  TextEditingController clientIdController;
  int selectedRadio = 0;
  final void Function(int, bool) onRadioSelected;
  void Function() nextStep;

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController centerNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController counselorNameController = TextEditingController();
  bool isCheck = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserController userController = context.read<UserController>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: defaultPadding * 4,
          ),
          Text(
            "무료 회원가입",
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(
            height: defaultPadding * 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("-디지털 플랫픔을 통해 고객정보를 관리할 수 있습니다.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  )),
              Text("-상담 데이터를 온라은으로 분석하고 관리할 수 있습니다.",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      height: 2)),
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
              textEditingController: widget.emailController,
              title: "이메일",
              hintText: "인증가능한 이메일 주소 입력",
            ),
          ),
          Expanded(
            child: UserFormField(
              textEditingController: centerNameController,
              title: "센터이름",
              hintText: "센터이름 입력",
            ),
          ),
          Expanded(
              child: UserFormField(
            title: "분류",
            hintText: "",
            isRadio: true,
            selectedRadio: widget.selectedRadio,
            onRadioSelected: widget.onRadioSelected,
          )),
          if (widget.selectedRadio == 1)
            Expanded(
              child: UserFormField(
                textEditingController: counselorNameController,
                title: "상담사 이름",
                hintText: "상담사 이름 입력",
              ),
            ),
          if (widget.selectedRadio == 1)
            Expanded(
              child: UserFormField(
                textEditingController: widget.clientIdController,
                title: "상담센터 인증코드",
                hintText: "센터 계정에서 발급된 인증코드를 입력하세요",
              ),
            ),
          Expanded(
            child: UserFormField(
              textEditingController: phoneNumberController,
              title: "연락처",
              hintText: "숫자만 입력",
            ),
          ),
          Expanded(
            child: UserFormField(
              textEditingController: passwordController,
              title: "비밀번호",
              hintText: "숫자, 특수문자 각 1회, 영문 2회 포함 8자리 이상",
              obscureText: true,
            ),
          ),
          Expanded(
            child: UserFormField(
              textEditingController: null,
              title: "비밀번호 확인",
              hintText: "비밀번호 다시입력",
              obscureText: true,
              validator: (value) {
                return value == passwordController.value.text
                    ? null
                    : "비밀번호가 같지 않습니다";
              },
            ),
          ),
          SizedBox(
            height: defaultPadding * 2,
          ),
          Row(
            children: [
              Checkbox(
                  value: isCheck,
                  onChanged: (value) {
                    setState(() {
                      isCheck = value!;
                    });
                  }),
              RichText(
                text: TextSpan(
                  text: "이용약관 동의 ",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                        text: "자세히보기",
                        style: TextStyle(
                          color: kSelectedContainerColor,
                          decoration: TextDecoration.underline,
                        )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: defaultPadding * 5,
          ),
          FormSubmitButton(
            title: "회원가입",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String email = widget.emailController.value.text;
                String password = passwordController.value.text;
                String centerName = centerNameController.value.text;
                String phoneNumber = phoneNumberController.value.text;
                String clientId = widget.clientIdController.value.text;

                var response = await userController.signUp(
                  email: email,
                  password: password,
                  centerName: centerName,
                  phoneNumber: phoneNumber,
                  clientId: clientId,
                );

                if (response == true) {
                  //todo 이메일 인증으로 이동

                  widget.nextStep();
                } else {
                  //todo 에러 처리
                }
              }
            },
          ),
          SizedBox(
            height: defaultPadding * 8,
          ),
        ],
      ),
    );
  }
}
