import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffordKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldkey => _scaffordKey;

  void controlMenu() {
    if (!_scaffordKey.currentState!.isDrawerOpen) {
      _scaffordKey.currentState!.openDrawer();
    }
  }
}
