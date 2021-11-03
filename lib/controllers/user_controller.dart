import 'package:ai_counseling_platform/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../network_helper.dart';

class UserController extends ChangeNotifier {
  User? user;

  Future testLogin() async {
    Uri test = Uri.parse(NetworkHelper.loginUrl);
    http.Response data = await http.post(
      test,
      body: json.encode({"ID": "dkdlakdlsem@gmail.com", "PW": "hj@1027612"}),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(data);
    return jsonDecode(data.body);
  }

  Future delete() async {
    var user = await testLogin();
    var url = Uri.parse(NetworkHelper.deleteUser);
    print(user);
    http.Response response = await http.delete(url, headers: {
      "ID": "dkdladklsem@gmail.com",
      "clientId": "32glofcblb4gr72ffs5uheskjs",
      "accessToken": user["body"]["AuthenticationResult"]["AccessToken"],
      "Authorization": user["body"]["AuthenticationResult"]["IdToken"]
    });
    print(response);
  }

  Future login({required String email, required String password}) async {
    var url = Uri.parse(NetworkHelper.loginUrl);
    http.Response response = await http.post(
      url,
      body: json.encode({"ID": email, "PW": password}),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      user = User(
        email: email,
        token: decodeData["body"]["AuthenticationResult"]["IdToken"],
        clientId: "32glofcblb4gr72ffs5uheskjs",
      );
      notifyListeners();
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  Future signUp({
    required email,
    required password,
    required centerName,
    required phoneNumber,
    required clientId,
  }) async {
    print(clientId);
    var url = Uri.parse(NetworkHelper.signupUrl);
    var response = await http.post(
      url,
      body: json.encode({
        "ID": email,
        "PW": password,
        "address": "강남구",
        "name": centerName,
        "phoneNumber": "+${phoneNumber.toString().substring(1)}",
        "clientId": clientId,
        "gender": "회사"
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      var decodeData = jsonDecode(response.body);
      return false;
    }
  }

  Future confirm({
    required email,
    required confirmCode,
    required clientId,
  }) async {
    var url = NetworkHelper.confirmUrl;
    var response = await http.post(
      Uri.parse(url),
      body: json.encode({
        "ID": email,
        "clientId": clientId,
        "code": confirmCode,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  logout() {
    //todo 로그인 http 통신
    user = null;
    notifyListeners();
  }
}
