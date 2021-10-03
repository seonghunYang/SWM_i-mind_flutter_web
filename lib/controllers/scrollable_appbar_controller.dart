import 'package:flutter/cupertino.dart';

class ScrollableAppbarController extends ChangeNotifier {
  bool isTransparent = true;

  void scrollListener(ScrollController scrollController) {
    scrollController.addListener(() {
      if (isTransparent == true && scrollController.offset >= 60) {
        isTransparent = false;
        notifyListeners();
      } else if (isTransparent == false && scrollController.offset <= 0) {
        isTransparent = true;
        notifyListeners();
      }
    });
  }
}
