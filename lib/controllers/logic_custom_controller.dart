import 'package:ai_counseling_platform/screens/custom_screen/components/custom_logic.dart';
import 'package:flutter/cupertino.dart';

class LogicCustomController extends ChangeNotifier {
  List<CustomLogic> customList = [
    CustomLogic(
      index: 1,
    ),
  ];

  void addLogicCustomer() {
    customList.add(CustomLogic(
      index: customList.length + 1,
    ));
    notifyListeners();
  }
}
