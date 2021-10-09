import 'package:ai_counseling_platform/controllers/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constants.dart';

const TextStyle headerTextStyle =
    TextStyle(fontWeight: FontWeight.bold, color: Colors.black38, fontSize: 12);
const EdgeInsetsGeometry headerPadding = EdgeInsets.symmetric(
    vertical: defaultPadding, horizontal: defaultPadding * 2);

class CustomerTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CustomerDataSource customerDataSource =
        context.watch<CustomerController>().getCustomerDataSource();
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
                  '고객ID',
                  style: headerTextStyle,
                ))),
        GridColumn(
            columnName: 'parentName',
            label: Container(
                color: kDasboardTextColor,
                padding: headerPadding,
                alignment: Alignment.centerLeft,
                child: Text(
                  '보호자',
                  style: headerTextStyle,
                ))),
        GridColumn(
            columnName: 'childName',
            label: Container(
                color: kDasboardTextColor,
                padding: headerPadding,
                alignment: Alignment.centerLeft,
                child: Text('자녀이름', style: headerTextStyle))),
        GridColumn(
            columnName: 'Age',
            label: Container(
                color: kDasboardTextColor,
                padding: headerPadding,
                alignment: Alignment.centerRight,
                child: Text(
                  '나이',
                  style: headerTextStyle,
                ))),
        GridColumn(
            columnName: 'gender',
            label: Container(
                color: kDasboardTextColor,
                padding: headerPadding,
                alignment: Alignment.centerRight,
                child: Text(
                  '성별',
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
                  'Email',
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
