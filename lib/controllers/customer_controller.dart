import 'package:ai_counseling_platform/model/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomerController extends ChangeNotifier {
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
    return CustomerDataSource(customers: customers);
  }
}

class CustomerDataSource extends DataGridSource {
  CustomerDataSource({required List<Customer> customers}) {
    _customers = customers
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<int>(columnName: 'Id', value: e.id),
              DataGridCell<String>(columnName: 'Category', value: e.category),
              DataGridCell<int>(columnName: 'Age', value: e.age),
              DataGridCell<String>(columnName: 'Gender', value: e.gender),
              DataGridCell<String>(columnName: 'Email', value: e.email),
            ]))
        .toList();
  }

  List<DataGridRow> _customers = [];

  @override
  List<DataGridRow> get rows => _customers;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getBackgroundColor() {
      int index = _customers.indexOf(row) + 1;
      if (index % 2 == 0) {
        return Colors.white;
      } else {
        return const Color(0xffd1f8e4).withOpacity(0.3);
      }
    }

    return DataGridRowAdapter(
        color: getBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: dataGridCell.columnName == "Id" ||
                    dataGridCell.columnName == "Name"
                ? Alignment.centerLeft
                : Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(dataGridCell.value.toString()),
          );
        }).toList());
  }
}
