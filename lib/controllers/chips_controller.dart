import 'package:flutter/cupertino.dart';

class ChipsController extends ChangeNotifier {
  List<int> selectedNumberKeyList = [];

  void updateSelectedNumberKeyList(int newValue) {
    selectedNumberKeyList.add(newValue);
    notifyListeners();
  }

  void removeSelectedNumberKeyList(int newValue) {
    selectedNumberKeyList.remove(newValue);
    notifyListeners();
  }
}
