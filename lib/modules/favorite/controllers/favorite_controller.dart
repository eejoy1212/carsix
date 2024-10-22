import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  // 스위치 상태를 관리하는 변수
  var isAutoBrightOn = false.obs;

  // 선택된 색상 변수
  var selectedColor = CarsixColors.primaryRed.obs;

  // 즐겨찾기 색상 리스트 (최대 6개)
  RxList<Color> favoriteColors = <Color>[].obs;

  // 스위치 상태 변경 함수
  void toggleAutoBright(bool value) {
    isAutoBrightOn.value = value;
  }

  // 즐겨찾기 색상 추가 함수
  void addToFavorites(Color color) {
    if (!favoriteColors.contains(color) && favoriteColors.length < 6) {
      favoriteColors.add(color);
    }
  }

  // 즐겨찾기 색상 제거 함수
  void removeFromFavorites(Color color) {
    favoriteColors.remove(color);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
