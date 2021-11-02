import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../network_helper.dart';
import 'package:stats/stats.dart';

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

    var response1 = json.decode(response.body);
    print(response1);

    Map emotionAll = {
      "parentEmotion": List<List<double>>.generate(
          response1['body'][0][0]["data"].length,
          (index) => [
                response1['body'][0][0]["data"][index][0].toDouble() / 1000,
                response1['body'][0][0]["data"][index][1]
              ]),
      "childEmotion": List<List<double>>.generate(
          response1['body'][1][0]["data"].length,
          (index) => [
                response1['body'][1][0]["data"][index][0].toDouble() / 1000,
                response1['body'][1][0]["data"][index][1]
              ]),
      "emotion": "행복",
    };
    return emotionAll;
  }

  Future getEmotionChild(var userInfo, String recordId) async {
    http.Response response = await http.get(
        Uri.parse(
            "${NetworkHelper.counselingDetailEmotionChild}?clientId=${userInfo["body"]["clientId"]}&num=$recordId"),
        headers: {
          "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        });

    var response1 = json.decode(response.body);
    print(response1);
    Map emotionChild = {
      "dataList": [],
      "emotionCategory": [],
    };
    for (int i = 0; i < response1["body"].length; i++) {
      emotionChild["dataList"].add(List<List<double>>.generate(
          response1["body"][i]["data"].length,
          (index) => [
                response1["body"][i]["data"][index][0].toDouble() / 1000,
                response1["body"][i]["data"][index][1]
              ]));
      emotionChild["emotionCategory"].add(response1["body"][i]["emotion"]);
    }
    return emotionChild;
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

    var response1 = json.decode(response.body);
    Map actionList = {
      "dataList": [],
      "actionCategory": [],
    };
    for (int i = 0; i < response1["body"].length; i++) {
      actionList["dataList"].add(List<List<double>>.generate(
          response1["body"][i]["data"].length,
          (index) => [
                response1["body"][i]["data"][index][0].toDouble() / 1000,
                response1["body"][i]["data"][index][1] * 100
              ]));
      actionList["actionCategory"].add(response1["body"][i]["action"]);
    }
    return actionList;
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

  Future getTalk(var userInfo, String recordId) async {
    http.Response response = await http.get(
        Uri.parse(
            "${NetworkHelper.counselingDetailTalk}?clientId=${userInfo["body"]["clientId"]}&num=$recordId"),
        headers: {
          "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        });

    var response1 = json.decode(response.body);
    int totalCount = response1["child_talk"] + response1["parent_talk"];
    double childPercentage = double.parse(
        (response1["child_talk"] / totalCount * 100).toStringAsFixed(1));

    Map talkPercentage = {
      "child": childPercentage,
      "parent": 100 - childPercentage,
    };
    print(talkPercentage);
    return talkPercentage;
  }

  Future getRecordVideo(var userInfo, String recordId) async {
    http.Response response = await http.get(
        Uri.parse(
            "${NetworkHelper.counselingRecordGetVideoUrl}?clientId=${userInfo["body"]["clientId"]}&num=$recordId"),
        headers: {
          "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        });

    return json.decode(response.body);
  }

  Future getCounselingDetail(String recordId) async {
    var userInfo = await testLogin();

    Map emotionAll = await getEmotionAll(userInfo, recordId);
    print(emotionAll);
    var response2 = await getRecordVideo(userInfo, recordId);
    var emotionChild = await getEmotionChild(userInfo, recordId);
    // var distance = await getDistance(userInfo, recordId);
    var actionList = await getActionList(userInfo, recordId);
    var actionTime = await getActionTime(userInfo, recordId);
    var talkPercentage = await getTalk(userInfo, recordId);
    print(talkPercentage);

    return {
      "emotionAll": emotionAll,
      "emotionChild": emotionChild,
      "actionTime": actionTime,
      "actionList": actionList,
      "talkPercentage": talkPercentage,
      // "distance": distance,
      "videoUrl": response2,
    };
  }
}
