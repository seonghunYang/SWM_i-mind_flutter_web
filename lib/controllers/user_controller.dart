import 'package:ai_counseling_platform/model/user.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  bool isLogin = false;
  User? user;

  bool login({required String email, required String password}) {
    //todo 로그인 http 통신
    user = User(email: email, centerName: "그로잉맘");
    isLogin = true;
    notifyListeners();
    return isLogin;
  }

  bool logout() {
    //todo 로그인 http 통신
    isLogin = false;
    notifyListeners();
    return true;
  }
}
