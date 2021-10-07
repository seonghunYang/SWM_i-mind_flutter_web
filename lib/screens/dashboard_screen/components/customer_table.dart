import 'package:ai_counseling_platform/controllers/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomerTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CustomerDataSource customerDataSource =
        context.watch<CustomerController>().getCustomerDataSource();
    return SfDataGrid(
      gridLinesVisibility: GridLinesVisibility.none,
      columnWidthMode: ColumnWidthMode.fill,
      rowHeight: 60,
      source: customerDataSource,
      columns: <GridColumn>[
        GridColumn(
            columnName: 'Name',
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))),
        GridColumn(
            columnName: 'Id',
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'ID',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))),
        GridColumn(
            columnName: 'Category',
            width: 120,
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))),
        GridColumn(
            columnName: 'Age',
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'Age',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))),
        GridColumn(
            columnName: 'Gender',
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'Gender',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))),
        GridColumn(
            columnName: 'Email',
            width: 190,
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))),
      ],
    );
  }
}
