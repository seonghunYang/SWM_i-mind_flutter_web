import 'package:ai_counseling_platform/constants.dart';
import 'package:ai_counseling_platform/controllers/user_controller.dart';
import 'package:ai_counseling_platform/screens/components/scrollable_appbar.dart';
import 'package:ai_counseling_platform/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'components/confirm_form.dart';
import 'components/signup_form.dart';
import 'components/user_form_field.dart';

import 'components/footer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static const String id = "SignupScreen";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController clientIdController = TextEditingController();
  bool emailConfirmStage = false;
  int selectedRadio = 0;

  Widget getSignupForm() {
    return emailConfirmStage
        ? ConfirmForm(
            emailController: emailController,
            clientIdController: clientIdController,
          )
        : SignupForm(
            emailController: emailController,
            nextStep: changeEmailConfirmStage,
            selectedRadio: selectedRadio,
            onRadioSelected: updateSelectedRadio,
            clientIdController: clientIdController,
          );
  }

  void changeEmailConfirmStage() {
    setState(() {
      emailConfirmStage = !emailConfirmStage;
    });
  }

  void updateSelectedRadio(int index, bool isSelected) {
    setState(() {
      selectedRadio = index;
    });
  }

  double updateFormHeight() {
    if (emailConfirmStage) return 450;
    if (selectedRadio == 0) {
      return 1100;
    } else {
      return 1350;
    }
  }

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
              height: updateFormHeight(),
              margin: EdgeInsets.all(defaultPadding * 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.3),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding * 10),
                child: getSignupForm(),
              ),
            ),
            const Footer(),
          ],
        ),
      )),
    );
  }
}
