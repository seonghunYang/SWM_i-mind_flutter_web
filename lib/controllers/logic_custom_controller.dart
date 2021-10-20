import 'package:ai_counseling_platform/screens/custom_screen/components/logic_custom.dart';
import 'package:flutter/cupertino.dart';

class LogicCustomController extends ChangeNotifier {
  List<LogicCustom> customList = [
    LogicCustom(
      index: 1,
    ),
  ];

  void addLogicCustomer() {
    customList.add(LogicCustom(
      index: customList.length + 1,
    ));
    notifyListeners();
  }
}
