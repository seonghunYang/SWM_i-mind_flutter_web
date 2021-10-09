import 'package:ai_counseling_platform/model/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../constants.dart';

class CustomerController extends ChangeNotifier {
  bool isSelected = true;
  String? selectedCustomerId;

  void selectCustomer() {
    isSelected = true;
    notifyListeners();
  }

  void unSelectCustomer() {
    isSelected = false;
    notifyListeners();
  }

  void getCustomerInfo(String customerId) async {
    //todo 고객 정보 받아오기
  }

  List<Customer> customers = [
    Customer(10001, '양성훈', "놀이영상분석", 6, "남", "didtjgns852@gmail.com"),
    Customer(10001, '양성훈', "놀이영상분석", 6, "남", "didtjgns852@gmail.com"),
    Customer(10001, '양성훈', "놀이영상분석", 6, "남", "didtjgns852@gmail.com"),
    Customer(10001, '양성훈', "놀이영상분석", 6, "남", "didtjgns852@gmail.com"),
    Customer(10001, '양성훈', "놀이영상분석", 6, "남", "didtjgns852@gmail.com"),
    Customer(10001, '양성훈', "놀이영상분석", 6, "남", "didtjgns852@gmail.com"),
    Customer(10001, '양성훈', "놀이영상분석", 6, "남", "didtjgns852@gmail.com"),
    Customer(10001, '양성훈', "놀이영상분석", 6, "남", "didtjgns852@gmail.com"),
    Customer(10001, '양성훈', "놀이영상분석", 6, "남", "didtjgns852@gmail.com"),
  ];

  CustomerDataSource getCustomerDataSource() {
    return CustomerDataSource(
        customers: customers,
        selectCustomer: selectCustomer,
        unSelectCustomer: unSelectCustomer);
  }
}

class CustomerDataSource extends DataGridSource {
  CustomerDataSource(
      {required List<Customer> customers,
      required selectCustomer,
      required unSelectCustomer}) {
    _customers = customers
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'Id', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(columnName: 'Category', value: e.category),
              DataGridCell<int>(columnName: 'Age', value: e.age),
              DataGridCell<String>(columnName: 'Gender', value: e.gender),
              DataGridCell<String>(columnName: 'Email', value: e.email),
              DataGridCell<String>(columnName: '', value: ""),
            ]))
        .toList();
    this.selectCustomer = selectCustomer;
    this.unSelectCustomer = unSelectCustomer;
  }

  List<DataGridRow> _customers = [];

  late void Function() selectCustomer;
  late void Function() unSelectCustomer;

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
              alignment: dataGridCell.columnName == "Id" ||
                      dataGridCell.columnName == "Name"
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                dataGridCell.value.toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            );
          }
        }).toList());
  }
}
