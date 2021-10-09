import 'package:ai_counseling_platform/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends ChangeNotifier {
  bool isLogin = false;
  User? user;

  login({required String email, required String password}) async {
    //todo 로그인 http 통신
    // var url = Uri.parse(
    //     'https://ha5evef96e.execute-api.ap-northeast-2.amazonaws.com/catch/cognito');
    // var response = await http.post(
    //   url,
    //   body: json.encode({'ID': 'puls7890@naver.com', 'PW': '12345678!'}),
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );

    // print(response.body);
    // print(jsonDecode(response.body));
    isLogin = true;
    notifyListeners();
  }

  bool logout() {
    //todo 로그인 http 통신
    isLogin = false;
    notifyListeners();
    return true;
  }
}
