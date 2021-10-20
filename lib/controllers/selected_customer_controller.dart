import 'dart:async';
import 'dart:convert';

import 'package:ai_counseling_platform/model/customer_detail.dart';
import 'package:ai_counseling_platform/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SelectedCustomerController extends ChangeNotifier {
  late List<Map<String, String>> indicatorRecordList;
  late Map<String, int> recentIndicator;
  late List avgIndicator;
  late List counselingRecordList;
  late Future<CustomerDetail> customerDetail;

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

  Future getRecordIndicator(var userInfo, String customerId) async {
    http.Response response = await http.get(
        Uri.parse(
            "${NetworkHelper.customerDetailRecordIndicatorUrl}?clientId=${userInfo["body"]["clientId"]}&patientId=$customerId"),
        headers: {
          "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        });

    return json.decode(response.body);
  }

  Future getRecentIndicator(var userInfo, String customerId) async {
    http.Response response = await http.get(
        Uri.parse(
            "${NetworkHelper.customerDetailRecentIndicatorUrl}?clientId=${userInfo["body"]["clientId"]}&patientId=$customerId"),
        headers: {
          "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        });
    return json.decode(response.body);
  }

  Future getCounselingRecord(var userInfo, String customerId) async {
    http.Response response = await http.get(
        Uri.parse(
            "${NetworkHelper.counselingRecordReadListUrl}?clientId=${userInfo["body"]["clientId"]}&patientId=$customerId"),
        headers: {
          "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        });
    return json.decode(response.body);
  }

  Future getCustomerDetail(String customerId) async {
    var userInfo = await testLogin();
    print(customerId);

    List recordIndicator = await getRecordIndicator(userInfo, customerId);
    var recentIndicator = await getRecentIndicator(userInfo, customerId);
    var counselingRecordList = await getCounselingRecord(userInfo, customerId);
    Map<String, List<int>> recordIndicatorList = {
      "responsiveness": [],
      "persistence": [],
      "scrupulosity": [],
    };
    List<String> counselingDate = [];

    recordIndicator.forEach((element) {
      counselingDate.add(element["date"]);
      recordIndicatorList["responsiveness"]!.add(element["responsiveness"]);
      recordIndicatorList["persistence"]!.add(element["persistence"]);
      recordIndicatorList["scrupulosity"]!.add(element["scrupulosity"]);
    });

    print(recordIndicatorList);

    return {
      "indicatorRecordList": recordIndicatorList,
      "date": counselingDate,
      "recentIndicator": recentIndicator["indicators"],
      "avgIndicator": recentIndicator["allIndicators"],
      "counselingRecordList": counselingRecordList
    };
  }
}
