import 'dart:convert';

import 'package:ai_counseling_platform/model/customer.dart';
import 'package:ai_counseling_platform/model/user.dart';
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
  bool isInit = false;
  late Customer selectedCustomer;
  List<Customer> customers = [];

  void selectCustomer(int selectedCustomerIndex) {
    isSelected = true;
    selectedCustomer = customers[selectedCustomerIndex];
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

    List customerInfoList = jsonDecode(response.body)["body"];

    setCustomerList(customerInfoList);
    if (isInit == false) {
      isInit = true;
    }
    notifyListeners();
    return true;
  }

  void setCustomerList(List customerRawList) {
    customers = List<Customer>.generate(customerRawList.length, (index) {
      DateTime childBirth =
          DateTime.parse(customerRawList[index]["child_birthday"]);
      DateTime parentBirth =
          DateTime.parse(customerRawList[index]["parent_birthday"]);
      int childAge = DateTime.now().difference(childBirth).inDays ~/ 30;
      int parentAge = DateTime.now().year - parentBirth.year;
      return Customer(
        id: customerRawList[index]["ID"].toString(),
        parentName: customerRawList[index]["parent_name"],
        childName: customerRawList[index]["child_name"],
        childAge: childAge.toString(),
        childGender: customerRawList[index]["child_gender"],
        parentAge: parentAge.toString(),
        parentRelation: customerRawList[index]["parent_relation"],
        email: customerRawList[index]["email"],
        special: customerRawList[index]["special"],
      );
    });
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
    isInit = false;
    notifyListeners();
    await getCustomerList(clientId: "asd", token: "asd");

    return true;
  }

  Future deleteCustomer({
    // required User user,
    required String id,
    required int index,
  }) async {
    var user = await testLogin();
    Uri url = Uri.parse(NetworkHelper.customerDeleteUrl);
    http.Response response = await http.delete(url,
        headers: {
          "Authorization": user["body"]["AuthenticationResult"]["IdToken"],
        },
        body: json
            .encode({"clientId": user["body"]["clientId"], "patientNum": id}));

    customers.removeAt(index);
    notifyListeners();
    if (response.statusCode == 200) {}
  }

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
              DataGridCell<String>(columnName: 'parentAge', value: e.parentAge),
              DataGridCell<String>(
                  columnName: 'parentRelation', value: e.parentRelation),
              DataGridCell<String>(columnName: 'childName', value: e.childName),
              DataGridCell<String>(columnName: 'childAge', value: e.childAge),
              DataGridCell<String>(
                  columnName: 'childGender', value: e.childGender),
              DataGridCell<String>(columnName: 'Email', value: e.email),
              DataGridCell<String>(columnName: '', value: ""),
            ]))
        .toList();
  }

  List<DataGridRow> _customers = [];

  late final void Function(int) selectCustomer;
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
                    String id = row.getCells()[0].value;
                    int index = _customers.indexOf(row);
                    if (value == 0) {
                      selectCustomer(index);
                      context.read<MenuController>().updateMenuIndex(1);
                    } else if (value == 1) {
                      context
                          .read<CustomerController>()
                          .deleteCustomer(id: id, index: index);
                    }
                  },
                  icon: Icon(
                    Icons.more_horiz_outlined,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 0,
                      child: Text(
                        '고객 상세정보',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 1,
                      child: Text(
                        '고객 삭제',
                        style: TextStyle(fontSize: 14),
                      ),
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
