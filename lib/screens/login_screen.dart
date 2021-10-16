import 'package:ai_counseling_platform/controllers/user_controller.dart';
import 'package:ai_counseling_platform/screens/components/form_submit_button.dart';
import 'package:ai_counseling_platform/screens/components/user_form_textfield.dart';
import 'package:ai_counseling_platform/screens/dashboard_screen/components/landing_screen.dart';
import 'package:ai_counseling_platform/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../constants.dart';
import 'components/footer.dart';
import 'components/scrollable_appbar.dart';
import 'components/user_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String id = "LoginScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollableAppbar(
        transparent: false,
        buttonColor: kSelectedContainerColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: 700,
                height: 450,
                margin: EdgeInsets.all(defaultPadding * 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: defaultPadding * 10),
                  child: LoginForm(),
                ),
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
            "로그인",
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(
            height: defaultPadding * 4,
          ),
          Expanded(
            child: UserFormTextField(
              textEditingController: emailController,
              obscureText: false,
              hintText: "이메일",
            ),
          ),
          Expanded(
            child: UserFormTextField(
              obscureText: true,
              textEditingController: passwordController,
              hintText: "비밀번호",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "비밀번호를 잊어버리셨나요?",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              )
            ],
          ),
          SizedBox(
            height: defaultPadding * 4,
          ),
          FormSubmitButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String password = passwordController.value.text;
                  String email = emailController.value.text;

                  var response = await userController.login(
                      email: email, password: password);
                  if (response == true) {
                    Navigator.pushNamed(context, LandingScreen.id);
                  } else {}
                }
                return;
              },
              title: "로그인"),
          SizedBox(
            height: defaultPadding * 4,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, SignupScreen.id);
            },
            child: RichText(
              text: TextSpan(
                  text: "회원이 아니신가요?  ",
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                  children: [
                    TextSpan(
                        text: "회원가입",
                        style: TextStyle(
                            color: kTextColor,
                            decoration: TextDecoration.underline))
                  ]),
            ),
          ),
          SizedBox(
            height: defaultPadding * 4,
          ),
        ],
      ),
    );
  }
}
