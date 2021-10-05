import 'package:flutter/cupertino.dart';

class ScrollPositionController extends ChangeNotifier {
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

  void scrollToPosition(ScrollController scrollController) {
    scrollController.jumpTo(340);

    notifyListeners();
  }
}
