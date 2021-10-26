import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../network_helper.dart';

class SelectedCounselingRecordController extends ChangeNotifier {
  Future testLogin() async {
    Uri test = Uri.parse(NetworkHelper.loginUrl);
    http.Response data = await http.post(
      test,
      body: json.encode({"ID": "s.h.yang0230@gmail.com", "PW": "11111111!"}),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return jsonDecode(data.body);
  }

  Future getEmotionAll(var userInfo, String recordId) async {
    http.Response response = await http.get(
        Uri.parse(
            "${NetworkHelper.counselingDetailEmotionAll}?clientId=${userInfo["body"]["clientId"]}&num=$recordId"),
        headers: {
          "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        });

    return json.decode(response.body);
  }

  Future getEmotionChild(var userInfo, String recordId) async {
    http.Response response = await http.get(
        Uri.parse(
            "${NetworkHelper.counselingDetailEmotionChild}?clientId=${userInfo["body"]["clientId"]}&num=$recordId"),
        headers: {
          "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        });

    return json.decode(response.body);
  }

  Future getDistance(var userInfo, String recordId) async {
    http.Response response = await http.get(
        Uri.parse(
            "${NetworkHelper.counselingDetailDistance}?clientId=${userInfo["body"]["clientId"]}&num=$recordId"),
        headers: {
          "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        });

    return json.decode(response.body);
  }

  Future getActionList(var userInfo, String recordId) async {
    http.Response response = await http.get(
        Uri.parse(
            "${NetworkHelper.counselingDetailActionList}?clientId=${userInfo["body"]["clientId"]}&num=$recordId"),
        headers: {
          "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        });

    return json.decode(response.body);
  }

  Future getActionTime(var userInfo, String recordId) async {
    http.Response response = await http.get(
        Uri.parse(
            "${NetworkHelper.counselingDetailActionTime}?clientId=${userInfo["body"]["clientId"]}&num=$recordId"),
        headers: {
          "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        });

    return json.decode(response.body);
  }
}
