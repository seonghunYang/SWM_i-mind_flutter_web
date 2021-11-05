import 'dart:convert';
import 'package:ai_counseling_platform/model/customer.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:ai_counseling_platform/controllers/menu_controller.dart';
import 'package:ai_counseling_platform/model/conseling_record.dart';
import 'package:ai_counseling_platform/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class CounselingRecordController extends ChangeNotifier {
  String? selectedCounselingRecordId;
  CounselingRecord? selectedCounselingRecord;
  String selectedFileName = "";
  bool isLoading = false;
  int currentIndex = 0;
  int counselingIndex = 0;

  List<CounselingRecord> counselingRecords = [];

  void updateCurrentIndex() {
    currentIndex = 1;
    notifyListeners();
  }

  void updateCounselingIndex() {
    counselingIndex = 1;
    notifyListeners();
  }

  void selectCounselingRecord(String id, int index) {
    selectedCounselingRecordId = id;
    selectedCounselingRecord = counselingRecords[index];
    //todo 탭바도 이
    notifyListeners();
  }

  void setCounselingRecordList(List rawCounselingRecordList, String childName) {
    print("c");
    counselingRecords = List<CounselingRecord>.generate(
        rawCounselingRecordList.length - 4, (index) {
      index = rawCounselingRecordList.length - index - 1;

      return CounselingRecord(
        counselingId: "${index - 1}",
        realId: rawCounselingRecordList[index]["ID"].toString(),
        customerId: rawCounselingRecordList[index]["patient_ID"].toString(),
        category: rawCounselingRecordList[index]["category"],
        childName: childName,
        counselingStatus: "${index - 1}" == "7"
            ? currentIndex == 1
                ? counselingIndex == 1
                    ? "일지작성"
                    : "분석완료"
                : "분석중..."
            : "상담완료",
        date: rawCounselingRecordList[index]["date"],
        counselor: "권윤정",
      );
    });
    notifyListeners();
  }

  void getCounselingRecordInfo(String customerId) async {
    //todo 상담기록들 가져오기
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

  Future getVideoFileSavedUrl() async {
    var userInfo = await testLogin();
    http.Response response = await http.post(
      Uri.parse(NetworkHelper.counselingRecordCreateUrl),
      body: json.encode({
        "clientId": userInfo["body"]["clientId"],
        "ID": "s.h.yang0230@gmail.com",
        "patientId": "11",
      }),
      headers: {
        "Authorization": userInfo["body"]["AuthenticationResult"]["IdToken"],
        'Content-Type': 'application/json',
      },
    );

    return jsonDecode(response.body);
  }

  void updateFileName(String newValue) {
    selectedFileName = newValue;
    notifyListeners();
  }

  Future createCounselingRecord({
    required List<int> selectedFile,
    required String bianry,
    required String fileName,
    required Customer selectedCustomer,
  }) async {
    var counselingInfo = await getVideoFileSavedUrl();
    var userInfo = await testLogin();
    DateTime current = DateTime.now();

    var metaVideoInfo = counselingInfo["url"];
    var dio = Dio();
    FormData formData = FormData.fromMap({
      "key": metaVideoInfo["fields"]["key"],
      "x-amz-algorithm": metaVideoInfo["fields"]["x-amz-algorithm"],
      "x-amz-credential": metaVideoInfo["fields"]["x-amz-credential"],
      "x-amz-date": metaVideoInfo["fields"]["x-amz-date"],
      "x-amz-security-token": metaVideoInfo["fields"]["x-amz-security-token"],
      "policy": metaVideoInfo["fields"]["policy"],
      "x-amz-signature": metaVideoInfo["fields"]["x-amz-signature"],
      "file": MultipartFile.fromBytes(selectedFile),
    });
    var response = await dio.post(
      metaVideoInfo["url"],
      data: formData,
      options: Options(
        headers: {
          Headers.contentLengthHeader: formData.length, // set content-length
        },
      ),
    );
    counselingRecords[0].counselingStatus = "분석중";
    notifyListeners();
    return false;
  }

  CounselingRecordDattaSource getCounselingRecordDattaSource(
    BuildContext context,
  ) {
    return CounselingRecordDattaSource(
      counselingRecordList: counselingRecords,
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
              DataGridCell<String>(columnName: 'childName', value: e.childName),
              DataGridCell<String>(columnName: 'counselor', value: e.counselor),
              DataGridCell<String>(columnName: 'category', value: e.category),
              DataGridCell<String>(
                  columnName: 'counselingStatus', value: e.counselingStatus),
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(columnName: '', value: ""),
            ]))
        .toList();
    this.selectCounselingRecord = selectCounselingRecord;
    this.context = context;
  }

  List<DataGridRow> _counselingRecordList = [];

  late void Function(String, int) selectCounselingRecord;
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

    Color getCounselingStatus(String status) {
      if (status == "분석중...") {
        return Colors.red;
      } else if (status == "분석완료") {
        return Colors.blue;
      } else if (status == "전송중...") {
        return Colors.red;
      } else if (status == "일지작성") {
        return kMainColor;
      } else {
        return kSelectedDashboardTextColor;
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
                    int index = _counselingRecordList.indexOf(row);
                    if (value == 0) {
                      selectCounselingRecord(row.getCells()[0].value, index);
                      context.read<MenuController>().updateMenuIndex(2);
                    } else if (value == 1) {
                      context.read<MenuController>().updateMenuIndex(3);
                    }
                  },
                  icon: Icon(
                    Icons.more_horiz_outlined,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 0,
                      child: Text('AI 분석리포트 조회'),
                    ),
                    if (row.getCells()[4].value == "상담완료" ||
                        row.getCells()[4].value == "일지작성")
                      PopupMenuItem(
                        value: 1,
                        child: Text('상담일지 조회'),
                      ),
                  ],
                ));
          } else {
            return Container(
              alignment: dataGridCell.columnName == "counselingId" ||
                      dataGridCell.columnName == "counselor" ||
                      dataGridCell.columnName == "childName"
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                dataGridCell.columnName == "counselingStatus"
                    ? "[${dataGridCell.value.toString()}]"
                    : dataGridCell.value.toString(),
                style: dataGridCell.columnName == "counselingStatus"
                    ? TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: getCounselingStatus(dataGridCell.value))
                    : TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
              ),
            );
          }
        }).toList());
  }
}
