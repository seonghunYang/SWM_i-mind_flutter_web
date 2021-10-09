import 'package:ai_counseling_platform/controllers/menu_controller.dart';
import 'package:ai_counseling_platform/model/conseling_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../constants.dart';

class CounselingRecordController extends ChangeNotifier {
  String? selectedCounselingRecordId;

  void selectCounselingRecord(String id) {
    selectedCounselingRecordId = id;
    //todo 탭바도 이
    notifyListeners();
  }

  void getCounselingRecordInfo(String customerId) async {
    //todo 상담기록들 가져오기
  }

  List<CounselingRecord> counselingRecordList = [
    CounselingRecord("1", "10001", "양성훈", "놀이영상분석", "2021-03-18"),
    CounselingRecord("2", "10001", "양성훈", "놀이영상분석", "2021-05-21"),
    CounselingRecord("3", "10001", "양성훈", "놀이영상분석", "2021-07-31"),
    CounselingRecord("4", "10001", "양성훈", "놀이영상분석", "2021-09-28"),
  ];

  CounselingRecordDattaSource getCounselingRecordDattaSource(
      BuildContext context) {
    return CounselingRecordDattaSource(
      counselingRecordList: counselingRecordList,
      selectCounselingRecord: selectCounselingRecord,
      context: context,
    );
  }
}

class CounselingRecordDattaSource extends DataGridSource {
  CounselingRecordDattaSource({
    required List<CounselingRecord> counselingRecordList,
    required selectCounselingRecord,
    required context,
  }) {
    _counselingRecordList = counselingRecordList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'counselingId', value: e.counselingId),
              DataGridCell<String>(
                  columnName: 'customerId', value: e.customerId),
              DataGridCell<String>(columnName: 'childName', value: e.childName),
              DataGridCell<String>(columnName: 'category', value: e.category),
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(columnName: '', value: ""),
            ]))
        .toList();
    this.selectCounselingRecord = selectCounselingRecord;
    this.context = context;
  }

  List<DataGridRow> _counselingRecordList = [];

  late void Function(String) selectCounselingRecord;
  late BuildContext context;
  @override
  List<DataGridRow> get rows => _counselingRecordList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getBackgroundColor() {
      int index = _counselingRecordList.indexOf(row) + 1;
      if (index % 2 != 0) {
        return Colors.white;
      } else {
        return kDasboardTextColor.withOpacity(0.3);
      }
    }

    return DataGridRowAdapter(
        color: getBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
          if (dataGridCell.columnName == "category") {
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
                      selectCounselingRecord(row.getCells()[0].value);
                      context.read<MenuController>().updateMenuIndex(2);
                    }
                  },
                  icon: Icon(
                    Icons.more_horiz_outlined,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 0,
                      child: Text('상담 기록 조회'),
                    ),
                  ],
                ));
          } else {
            return Container(
              alignment: dataGridCell.columnName == "counselingId" ||
                      dataGridCell.columnName == "customerId" ||
                      dataGridCell.columnName == "childName"
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
