import 'package:flutter/material.dart';

import '../../../constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: false,
      decoration: InputDecoration(
        suffixIcon: Container(
          child: Icon(
            Icons.search,
            size: 20,
            color: kSelectedDashboardTextColor,
          ),
          margin: EdgeInsets.all(2),
          height: 20,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: kDasboardTextColor,
          ),
        ),
        prefixIcon: Icon(
          Icons.filter_alt_outlined,
          color: Colors.black26,
        ),
        hintText: "고객 검색 필터",
        hintStyle: TextStyle(fontSize: 13, color: Colors.black38),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            width: 0.1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: kSelectedDashboardTextColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
    );
  }
}
