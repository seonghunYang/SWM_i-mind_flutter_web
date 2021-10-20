import 'package:ai_counseling_platform/controllers/counseling_record_controller.dart';
import 'package:ai_counseling_platform/controllers/customer_controller.dart';
import 'package:ai_counseling_platform/model/conseling_record.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constants.dart';

const TextStyle headerTextStyle =
    TextStyle(fontWeight: FontWeight.bold, color: Colors.black38, fontSize: 12);
const EdgeInsetsGeometry headerPadding = EdgeInsets.symmetric(
    vertical: defaultPadding, horizontal: defaultPadding * 2);

class CounselingRecordTable extends StatelessWidget {
  final List<CounselingRecord> counselingRecordList;

  CounselingRecordTable({
    required this.counselingRecordList,
  });

  @override
  Widget build(BuildContext context) {
    final CounselingRecordDattaSource counselingRecordDattaSource = context
        .watch<CounselingRecordController>()
        .getCounselingRecordDattaSource(context, counselingRecordList);
    return SfDataGrid(
      selectionMode: SelectionMode.single,
      headerGridLinesVisibility: GridLinesVisibility.none,
      headerRowHeight: 40,
      gridLinesVisibility: GridLinesVisibility.none,
      columnWidthMode: ColumnWidthMode.fill,
      rowHeight: 60,
      source: counselingRecordDattaSource,
      columns: <GridColumn>[
        GridColumn(
            columnName: 'counselingId',
            label: Container(
                color: kDasboardTextColor,
                padding: headerPadding,
                alignment: Alignment.centerLeft,
                child: Text(
                  '번호',
                  style: headerTextStyle,
                ))),
        GridColumn(
            columnName: 'childName',
            label: Container(
                color: kDasboardTextColor,
                padding: headerPadding,
                alignment: Alignment.centerLeft,
                child: Text(
                  '아이이름',
                  style: headerTextStyle,
                ))),
        GridColumn(
            columnName: 'counselor',
            label: Container(
                color: kDasboardTextColor,
                padding: headerPadding,
                alignment: Alignment.centerLeft,
                child: Text(
                  '상담사',
                  style: headerTextStyle,
                ))),
        GridColumn(
            columnName: 'category',
            width: 120,
            label: Container(
                color: kDasboardTextColor,
                padding: headerPadding,
                alignment: Alignment.centerRight,
                child: Text('상담종류', style: headerTextStyle))),
        GridColumn(
            columnName: 'counselingStatus',
            label: Container(
                color: kDasboardTextColor,
                padding: headerPadding,
                alignment: Alignment.centerRight,
                child: Text(
                  '상태',
                  style: headerTextStyle,
                ))),
        GridColumn(
            columnName: 'date',
            maximumWidth: 150,
            label: Container(
                color: kDasboardTextColor,
                padding: headerPadding,
                alignment: Alignment.centerRight,
                child: Text(
                  '날짜',
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
