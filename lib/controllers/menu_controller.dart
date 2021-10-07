import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffordKey = GlobalKey<ScaffoldState>();

  int selectedMenuIndex = 1;

  GlobalKey<ScaffoldState> get scaffoldkey => _scaffordKey;

  void controlMenu() {
    if (!_scaffordKey.currentState!.isDrawerOpen) {
      _scaffordKey.currentState!.openDrawer();
    }
  }

  void updateMenuIndex(int newIndex) {
    selectedMenuIndex = newIndex;
    notifyListeners();
  }
}
