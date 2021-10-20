import 'package:ai_counseling_platform/controllers/customer_controller.dart';
import 'package:ai_counseling_platform/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constants.dart';

const TextStyle headerTextStyle =
    TextStyle(fontWeight: FontWeight.bold, color: Colors.black38, fontSize: 11);
const EdgeInsetsGeometry headerPadding = EdgeInsets.symmetric(
    vertical: defaultPadding, horizontal: defaultPadding * 2);

class CustomerTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CustomerController customerController =
        context.watch<CustomerController>();
    final UserController userController = context.read<UserController>();

    if (!customerController.isInit) {
      customerController.getCustomerList(token: "asd", clientId: "ASd");
      return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      );
    } else {
      final CustomerDataSource customerDataSource =
          customerController.getCustomerDataSource(context: context);
      return SfDataGrid(
        selectionMode: SelectionMode.single,
        headerGridLinesVisibility: GridLinesVisibility.none,
        headerRowHeight: 40,
        gridLinesVisibility: GridLinesVisibility.none,
        columnWidthMode: ColumnWidthMode.fill,
        rowHeight: 60,
        source: customerDataSource,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'Id',
              label: Container(
                  color: kDasboardTextColor,
                  padding: headerPadding,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '고객번호',
                    style: headerTextStyle,
                  ))),
          GridColumn(
              columnName: 'parentName',
              label: Container(
                  color: kDasboardTextColor,
                  padding: headerPadding,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '부모이름',
                    style: headerTextStyle,
                  ))),
          GridColumn(
              columnName: 'parentAge',
              label: Container(
                  color: kDasboardTextColor,
                  padding: headerPadding,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '부모나이',
                    style: headerTextStyle,
                  ))),
          GridColumn(
              columnName: 'parentRelation',
              label: Container(
                  color: kDasboardTextColor,
                  padding: headerPadding,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '부모관계',
                    style: headerTextStyle,
                  ))),
          GridColumn(
              columnName: 'childName',
              label: Container(
                  color: kDasboardTextColor,
                  padding: headerPadding,
                  alignment: Alignment.centerLeft,
                  child: Text('아이이름', style: headerTextStyle))),
          GridColumn(
              columnName: 'childAge',
              label: Container(
                  color: kDasboardTextColor,
                  padding: headerPadding,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '아이나이',
                    style: headerTextStyle,
                  ))),
          GridColumn(
              columnName: 'childGender',
              label: Container(
                  color: kDasboardTextColor,
                  padding: headerPadding,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '아이성별',
                    style: headerTextStyle,
                  ))),
          GridColumn(
              columnName: 'Email',
              width: 190,
              label: Container(
                  color: kDasboardTextColor,
                  padding: headerPadding,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '이메일',
                    style: headerTextStyle,
                  ))),
          GridColumn(
              columnName: '',
              maximumWidth: 80,
              label: Container(
                  color: kDasboardTextColor,
                  padding: headerPadding,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '',
                    style: headerTextStyle,
                  ))),
        ],
      );
    }
  }
}
