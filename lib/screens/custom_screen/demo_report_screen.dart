import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/demo_custom_record_page.dart';

class DemoReportScreen extends StatefulWidget {
  const DemoReportScreen({Key? key}) : super(key: key);

  static String id = "DemoReportScreen";

  @override
  _DemoReportScreenState createState() => _DemoReportScreenState();
}

class _DemoReportScreenState extends State<DemoReportScreen> {
  final ScrollController _scrollController = ScrollController();
  bool visible = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffd1f8e4).withOpacity(0.3),
      padding: EdgeInsets.only(
        left: defaultPadding * 15,
        right: defaultPadding * 15,
        top: defaultPadding * 2,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton:  Padding(
          padding: const EdgeInsets.all(defaultPadding * 2),
          child: SizedBox(
            width: 80,
            height: 80,
            child: FloatingActionButton(
              backgroundColor: kMainColor,
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ();
                    });
              },
              child: Text(
                "로직\n변경",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: false,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.grey,
              )),
          elevation: 1,
          backgroundColor: Colors.white,
          title: Text("분석지표 데모",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 20)),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 3, vertical: defaultPadding * 2),
            child: Builder(
              builder: (context) {
                if (!visible) {
                  Future.delayed(Duration(seconds: 1), () {
                    setState(() {
                      visible = true;
                    });
                  });
                  return SizedBox(
                    height: 600,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  );
                } else {
                  return DemoCustomRecordPage();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
