import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  static const _ROOT_API =
      "https://4qkjdomaqf.execute-api.ap-northeast-2.amazonaws.com/catch";

  static String loginUrl = "$_ROOT_API/member/login";
  static String signupUrl = "$_ROOT_API/member/signup";
  static String deleteUser = "$_ROOT_API/test/delete";
  static String confirmUrl = "$_ROOT_API/member/confirm";
  static String customerReadListUrl = "$_ROOT_API/customer/customerlist";
  static String customerCreateUrl = "$_ROOT_API/customer/create";
  static String customerDeleteUrl = "$_ROOT_API/customer/delete";
  static String customerUpdateUrl = "$_ROOT_API/customer/update";
  static String customerDetailRecordIndicatorUrl =
      "$_ROOT_API/customer/detail/indicators";
  static String customerDetailRecentIndicatorUrl =
      "$_ROOT_API/customer/detail/avgindicators";
  static String counselingRecordReadListUrl =
      "$_ROOT_API/counselingrecord/recordlist";

  static String counselingRecordCreateUrl = "$_ROOT_API/recordcontrol";
  static String counselingRecordGetVideoUrl = "$_ROOT_API/recordlist";
  static String counselingDetailTalk = "$_ROOT_API/customer/detail/talk";
  static String counselingDetailEmotionAll =
      "$_ROOT_API/customer/detail/emotion/all";
  static String counselingDetailEmotionChild =
      "$_ROOT_API/customer/detail/emotion/child";
  static String counselingDetailDistance =
      "$_ROOT_API/customer/detail/distance";
  static String counselingDetailActionList =
      "$_ROOT_API/customer/detail/action/list";
  static String counselingDetailActionTime =
      "$_ROOT_API/customer/detail/action/time";
}
