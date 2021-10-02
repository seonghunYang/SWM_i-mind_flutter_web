import 'package:flutter/cupertino.dart';

class ScrollableAppbarController extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();

  bool isTransparent = true;

  ScrollController getScrollController() {
    scrollListener();
    return _scrollController;
  }

  void scrollListener() {
    _scrollController.addListener(() {
      if (isTransparent == true && _scrollController.offset >= 60) {
        isTransparent = false;
        notifyListeners();
      } else if (isTransparent == false && _scrollController.offset <= 0) {
        isTransparent = true;
        notifyListeners();
      }
    });
  }
}
