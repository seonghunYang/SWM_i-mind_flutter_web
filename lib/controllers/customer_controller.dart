import 'dart:convert';

import 'package:ai_counseling_platform/model/customer.dart';
import 'package:ai_counseling_platform/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'menu_controller.dart';

class CustomerController extends ChangeNotifier {
  bool isSelected = false;
  String? selectedCustomerId;

  void selectCustomer() {
    isSelected = true;
    notifyListeners();
  }

  void unSelectCustomer() {
    isSelected = false;
    notifyListeners();
  }

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

  Future getCustomerList(
      {required String token, required String clientId}) async {
    var userInfo = await testLogin();

    var url = Uri.parse(
        "${NetworkHelper.customerReadListUrl}?clientId=${userInfo["body"]["clientId"]}");
    http.Response response = await http.get(url, headers: {
      "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
    });

    print(response.body);
  }

  Future createCustomer({
    required String childName,
    required String childBirthday,
    required String childGender,
    required String parentName,
    required String parentRelation,
    required String parentBirthday,
    required String email,
    required String special,
  }) async {
    var userInfo = await testLogin();

    Uri url = Uri.parse(NetworkHelper.customerCreateUrl);
    http.Response response = await http.post(
      url,
      headers: {
        "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "clientId": userInfo["body"]["clientId"],
        "childName": childName,
        "childBirthday": childBirthday,
        "childGender": childGender,
        "parentName": parentName,
        "parentRelation": parentRelation,
        "parentBirthday": parentBirthday,
        "email": email,
        "special": special,
      }),
    );

    print(response.body);

    return false;
  }

  List<Customer> customers = [
    Customer(
      id: "1001",
      parentName: "양희남",
      childName: "양성훈",
      childAge: 41,
      childGender: "남아",
      parentAge: 38,
      parentRelation: "아빠",
      email: "didtjdgns852@gmail.com",
      special: "리틀소시에 / 수 23시",
    ),
    Customer(
      id: "1001",
      parentName: "양희남",
      childName: "양성훈",
      childAge: 41,
      childGender: "남아",
      parentAge: 38,
      parentRelation: "아빠",
      email: "didtjdgns852@gmail.com",
      special: "리틀소시에 / 수 23시",
    ),
    Customer(
      id: "1001",
      parentName: "양희남",
      childName: "양성훈",
      childAge: 41,
      childGender: "남아",
      parentAge: 38,
      parentRelation: "아빠",
      email: "didtjdgns852@gmail.com",
      special: "리틀소시에 / 수 23시",
    ),
    Customer(
      id: "1001",
      parentName: "양희남",
      childName: "양성훈",
      childAge: 41,
      childGender: "남아",
      parentAge: 38,
      parentRelation: "아빠",
      email: "didtjdgns852@gmail.com",
      special: "리틀소시에 / 수 23시",
    ),
    Customer(
      id: "1001",
      parentName: "양희남",
      childName: "양성훈",
      childAge: 41,
      childGender: "남아",
      parentAge: 38,
      parentRelation: "아빠",
      email: "didtjdgns852@gmail.com",
      special: "리틀소시에 / 수 23시",
    ),
    Customer(
      id: "1001",
      parentName: "양희남",
      childName: "양성훈",
      childAge: 41,
      childGender: "남아",
      parentAge: 38,
      parentRelation: "아빠",
      email: "didtjdgns852@gmail.com",
      special: "리틀소시에 / 수 23시",
    ),
  ];

  CustomerDataSource getCustomerDataSource({required BuildContext context}) {
    return CustomerDataSource(
        customers: customers,
        selectCustomer: selectCustomer,
        unSelectCustomer: unSelectCustomer,
        context: context);
  }
}

class CustomerDataSource extends DataGridSource {
  CustomerDataSource({
    required List<Customer> customers,
    required this.selectCustomer,
    required this.unSelectCustomer,
    required this.context,
  }) {
    _customers = customers
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Id', value: e.id),
              DataGridCell<String>(
                  columnName: 'parentName', value: e.parentName),
              DataGridCell<int>(columnName: 'parentAge', value: e.parentAge),
              DataGridCell<String>(
                  columnName: 'parentRelation', value: e.parentRelation),
              DataGridCell<String>(columnName: 'childName', value: e.childName),
              DataGridCell<int>(columnName: 'childAge', value: e.childAge),
              DataGridCell<String>(
                  columnName: 'childGender', value: e.childGender),
              DataGridCell<String>(columnName: 'Email', value: e.email),
              DataGridCell<String>(columnName: '', value: ""),
            ]))
        .toList();
  }

  List<DataGridRow> _customers = [];

  late final void Function() selectCustomer;
  late final void Function() unSelectCustomer;
  late final BuildContext context;

  @override
  List<DataGridRow> get rows => _customers;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getBackgroundColor() {
      int index = _customers.indexOf(row) + 1;
      if (index % 2 != 0) {
        return Colors.white;
      } else {
        return kDasboardTextColor.withOpacity(0.3);
      }
    }

    String getText(DataGridCell cell) {
      String text = cell.value.toString();
      if (cell.columnName == "childAge") {
        text = text + "개월";
      } else if (cell.columnName == "parentAge") {
        text = text + "세";
      }
      return text;
    }

    return DataGridRowAdapter(
        color: getBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
          if (dataGridCell.columnName == "Category") {
            return Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffDDF0DD),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                    vertical: defaultPadding * 0.25),
                child: Text(
                  dataGridCell.value.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff26A429)),
                ),
              ),
            );
          } else if (dataGridCell.columnName == "") {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 0) {
                      selectCustomer();
                      context.read<MenuController>().updateMenuIndex(1);
                    }
                  },
                  icon: Icon(
                    Icons.more_horiz_outlined,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 0,
                      child: Text('고객 상세정보'),
                    ),
                  ],
                ));
          } else {
            return Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                getText(dataGridCell),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            );
          }
        }).toList());
  }
}
