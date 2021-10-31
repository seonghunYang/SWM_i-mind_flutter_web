import 'package:flutter/material.dart';

const kTextTheme = TextTheme(
  headline1: TextStyle(
    color: Colors.black,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  ),
  headline2: TextStyle(
    color: Colors.black,
    fontSize: 34,
    fontWeight: FontWeight.bold,
  ),
  headline3: TextStyle(
    color: Colors.black,
    fontSize: 40,
    fontWeight: FontWeight.w500,
  ),
  headline4: TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  subtitle1: TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  subtitle2: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  bodyText1: TextStyle(color: Colors.black, fontSize: 14),
  bodyText2: TextStyle(color: Colors.white, fontSize: 14),
);

const defaultPadding = 8.0;

const kMainColor = Color(0xff03CFB5);

// const kSelectedContainerColor = Color(0xff6791e9);
const kSelectedContainerColor = Color(0xff4B9BFB);
const kTextColor = Color(0xff1253f3);

const kContainerColor = Color(0xffD5E9FF);

const List<String> actionLabels = [
  "대화 듣기",
  "말하기",
  "물체 보기",
  "물체 잡기",
  "물체 던지기",
  "식사하기",
  "폭력적인 행동",
  "앉기",
  "일어나기",
  "싸우기",
  "걷기",
  "뛰기",
  "밀기",
  "손 흔들기",
  "읽기",
];

const List<String> emotionLabels = [
  "중립",
  "행복",
  "슬픔",
  "분노",
  "공포",
  "놀람",
  "혼란",
];

const kDashboardMenuColor = Color(0xffFEFDFF);

// const kDashboardMenuColor = Color(0xfff9fafb);
const kDashboardTextColor = Color(0xffa3acad);
const kSelectedDashboardTextColor = Color(0xff49AD77);
const kDasboardTextColor = Color(0xffD1F8E4);

const kLandingMainColor = Color(0xff49c196);

const indicatorHappyMessage =
    "1점: 10% 이하\n2점: 15% 이하\n3점: 17.5% 이하\n4점: 20% 이하\n5점: 25% 이하\n6점: 30% 이하\n7점: 40% 이하\n8점: 50% 이하\n9점: 60% 이하\n10점: 나머지";
const indicatorLeadingMessage =
    "1점: -30% 이하\n2점: -20% 이하\n3점: -10% 이하\n4점: 0% 이하\n5점: 10% 이하\n6점: 20% 이하\n7점: 35% 이하\n8점: 42.5% 이하\n9점: 50% 이하\n10점: 나머지";

const indicatorTouchMessage =
    "1점: 0.8 이상\n2점: 0.7 이상\n3점: 0.6 이상\n4점: 0.5 이상\n5점: 0.4 이상\n6점: 0.35 이상\n7점: 0.3 이상\n8점: 0.25 이상\n9점: 0.2 이상\n10점: 나머지";

const indicatorConsistenceMessage =
    "1점: 60초 이하\n2점: 70초 이하\n3점: 80초 이하\n4점: 90초 이하\n5점: 110초 이하\n6점: 130초 이하\n7점: 150초 이하\n8점: 180초 이하\n9점: 210초 이하\n10점: 나머지";

const List<String> stepFourlabelList = [
  "최대값 비교",
  "최소값 비교",
  "평균값 비교",
  "차이 비교",
  "값 비교"
];
