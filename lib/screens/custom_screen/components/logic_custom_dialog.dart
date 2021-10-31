import 'package:ai_counseling_platform/controllers/logic_custom_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogicCustomDialog extends StatelessWidget {
  const LogicCustomDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "로직 수정",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Container(
        width: 1000,
        height: 650,
        child: SingleChildScrollView(
          child: Consumer<LogicCustomController>(
              builder: (context, logicCustomController, __) {
            return Column(
              children: logicCustomController.customList,
            );
          }),
        ),
      ),
    );
  }
}
