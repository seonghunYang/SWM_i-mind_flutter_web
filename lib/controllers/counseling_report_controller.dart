import 'dart:math';

import 'package:ai_counseling_platform/controllers/slider_controller.dart';
import 'package:ai_counseling_platform/model/guide_ment.dart';
import 'package:flutter/cupertino.dart';

class CounselingReportController extends ChangeNotifier {
  // TextEditingController statSensitivity = TextEditingController();
  // TextEditingController statRepeat = TextEditingController();
  // TextEditingController statHappy = TextEditingController();
  // TextEditingController statLeading = TextEditingController();
  // TextEditingController statPersistence = TextEditingController();

  SliderController statRepeat = SliderController(
      value: 5,
      tooltipMessage:
          "0 - 2: 한번하고 안되면 재시도 전혀 없음 / 패턴 없음. 놀이 안에 패턴이 있으면 무조건 4점 이상\n3 - 4: 약간의 패턴 반복만 관찰됨\n5 - 6: 놀이 중 여러 번의 같은 패턴을 반복함\n7 - 8: 여러 번 같은 패턴을 반복하며 실패에도 도전하는 양상을 보임 /실패 혹은 잘 안되는 데도 반복하여 시도하는 에피소드 추가 (장면에서 관찰 불가시 6점에서 머뭄)\n9 - 10: 명백히 실패가 되었는데도 될 때까지 끝까지 반복하며 도전함");
  SliderController statSensitivity = SliderController(
      value: 5,
      tooltipMessage:
          "0 - 2: 고립된 혼자만의 형태, 함께하기 전혀 안됨\n3 - 4: 가끔 자신의 관심을 보여줌\n5 - 6: 자신의 관심을 공유함 + 가끔씩 눈맞춤/ 적당히 봐주는 정도\n7 - 8: 적극적으로 관심 공유함 + 잦은 눈맞춤/ 끊임없이 눈을 맞추려 노력하고 엄마의 관심을 끌어오려함.\n9 - 10: 적극적으로 관심 공유함 + 잦은 눈맞춤 + 엄마의 제안에도 협력함/ 눈을 보면서 계속 대화가 됨. 성인들이 이야기 하듯함");
  SliderController statHappy = SliderController(
      value: 5,
      tooltipMessage:
          "0 - 2: 즐거움이 전혀 없음. 지루함\n3 - 4: 지루해보이지 않는 정도. 보통의 정서상태 / 무미건조해 보임. 뚱한 모습\n5 - 6: 보통 강도의 즐거움 (흥분이나 깔깔거림은 없음) / 약간의 웃는 모습\n7 - 8: 즐거움이 확실히 있음(깔깔거리는 웃음소리 등의 출연)\n9 - 10: 매우 즐거워 보임 (흥분된 몸짓, 깔깔거리는 소리의 반복) / 목소리 격앙, 날아다니고, 신나서 뛰어다님");
  SliderController statLeading = SliderController(
      value: 5,
      tooltipMessage:
          "0 - 2: 스스로 놀이 시작이 전혀 안됨\n3 - 4: 스스로 하는 놀이보다 부모 주도에 더 많이 따라감/ 시작은 했는데 주도권 뺏기고 있는 모습이 절반 이상인 경우\n5 - 6: 스스로 놀이 함 + 가끔 엄마 주도에 끌려감 / 스스로 놀이 시작가능, 엄마의 주도에 약간 끌려가기도 함\n7 - 8: 대부분 주도적으로 놀이를 끌고감 /스스로 놀이 시작 가능, 놀이를 거의 대부분이 자신이 주도해서 끌고감. 엄마는 보조역할임이 느껴짐\n9 - 10: 스스로 놀이의 시작과 진행을 끌고가며 자신의 방향을 적극적으로 설명함 / 자신의 놀이에 대해 엄마를 설득하고, 엄마를 완벽한 놀이 보조자로 끌고 가는 모습");
  SliderController statPersistence = SliderController(
      value: 5,
      tooltipMessage:
          "0 - 2: 몰입 없음. 시간 내 5개 이상의 놀이감 변동 있음. / 놀이 하나에 집중하지 못하고 확실히 산만한 느낌이 있음.\n3 - 4: 두세가지 이상의 상이한 놀이 공존 / 장난감 종류 자체가 바뀜\n5 - 6: 한두가지의 상이한 놀이 공존 / 집중이 있으나, 상이한 장난감이 1-2가지 정도 존재\n7 - 8: 한가지 정도의 장난감(놀이)로 여러 갈래로 주제 변형/ 한 가지 정도의 장난감을 가지고 집중하여 놀이, 주제는 여러가지\n9 - 10: 스한가지 놀이의 깊은 확장과 몰입/ 한가지 놀이가 끊기지 않고 쭉 이어지되, 주변의 도구를 많이 사용하더라도 확실히 그 놀이의 확장을 위함으로 여겨짐. Ex)블록으로 작게 만들다가 주방 도구까지 동원해서 성으로 완성 하는 모습.");

  TextEditingController childPositive = TextEditingController();
  TextEditingController childNegative = TextEditingController();
  TextEditingController parentPositive = TextEditingController();
  TextEditingController parentNegative = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController recommended = TextEditingController();

  bool checkedStatus = true;

  int getMinStatIndex() {
    int sensitivity = statSensitivity.value;
    int repeat = statRepeat.value;
    int happy = statHappy.value;
    int leading = statLeading.value;
    int persistence = statPersistence.value;

    List<int> statScoreList = [
      sensitivity,
      repeat,
      happy,
      leading,
      persistence
    ];

    int minValue = statScoreList.reduce(min);
    int minIndex = statScoreList.indexOf(minValue);
    return minIndex;
  }

  void updateSliderController(
      SliderController sliderController, dynamic value) {
    sliderController.updateValue(value);
    notifyListeners();
  }

  int getMaxStatIndex() {
    int sensitivity = statSensitivity.value;
    int repeat = statRepeat.value;
    int happy = statHappy.value;
    int leading = statLeading.value;
    int persistence = statPersistence.value;

    List<int> statScoreList = [
      sensitivity,
      repeat,
      happy,
      leading,
      persistence
    ];

    int maxValue = statScoreList.reduce(max);
    int maxIndex = statScoreList.indexOf(maxValue);
    return maxIndex;
  }

  setGuideMent() {
    int minIndex = getMinStatIndex();
    childNegative.text = guideMent[1].content[minIndex];
    parentNegative.text = guideMent[3].content[minIndex];

    int maxIndex = getMaxStatIndex();
    childPositive.text = guideMent[0].content[maxIndex];
    parentPositive.text = guideMent[2].content[maxIndex];

    checkedStatus = false;
    notifyListeners();
  }
}
