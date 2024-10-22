import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  // 스위치 상태를 관리하는 변수
  var isAutoBrightOn = false.obs;
  var currentIndex = 0.obs;

  // 레인지 슬라이더 값 상태를 관리하는 변수
  var currentRangeValues = RangeValues(20, 80).obs;
  // 선택된 색상 변수
  var selectedColor = CarsixColors.primaryRed.obs;
  RxList<Color> favoriteColors = RxList.empty();
  // 스위치 상태 변경 함수
  void toggleAutoBright(bool value) {
    isAutoBrightOn.value = value;
  }

  // 레인지 슬라이더 값 변경 함수
  void updateRangeValues(RangeValues values) {
    currentRangeValues.value = values;
  }

  @override
  void onInit() {
    super.onInit();
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
