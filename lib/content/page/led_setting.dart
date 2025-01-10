import 'package:carsix/const/color.dart';
import 'package:carsix/const/style.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/widget/bar/default_appbar.dart';
import 'package:carsix/widget/paper/favorite_color_paper.dart';
import 'package:carsix/widget/slider/carsix_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LedSetting extends StatelessWidget {
  const LedSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final BLEController controller = Get.find<BLEController>();
    final String? typeString = Get.parameters['type'];
    double getBright() {
      final currnteModel = controller.lightingModel.value;
      if (typeString == "좌측 센터") {
        return currnteModel.leftCenterBright;
      } else if (typeString == "우측 센터") {
        return currnteModel.rightCenterBright;
      } else if (typeString == "좌측 1열 운전석") {
        return currnteModel.leftFirstDriverBright;
      } else if (typeString == "우측 1열 조수석") {
        return currnteModel.rightFirstPassengerBright;
      } else if (typeString == "좌측 2열 운전석") {
        return currnteModel.leftSecondDriverBright;
      } else {
        //우측 2열 조수석
        return currnteModel.rightSecondPassengerBright;
      }
    }

    void onBrightChange(double bright) {
      final currnteModel = controller.lightingModel.value;
      if (typeString == "좌측 센터") {
        controller.lightingModel.value =
            currnteModel.copyWith(leftCenterBright: bright);
      } else if (typeString == "우측 센터") {
        controller.lightingModel.value =
            currnteModel.copyWith(rightCenterBright: bright);
      } else if (typeString == "좌측 1열 운전석") {
        controller.lightingModel.value =
            currnteModel.copyWith(leftFirstDriverBright: bright);
      } else if (typeString == "우측 1열 조수석") {
        controller.lightingModel.value =
            currnteModel.copyWith(rightFirstPassengerBright: bright);
      } else if (typeString == "좌측 2열 운전석") {
        controller.lightingModel.value =
            currnteModel.copyWith(leftSecondDriverBright: bright);
      } else {
        //우측 2열 조수석
        controller.lightingModel.value =
            currnteModel.copyWith(rightSecondPassengerBright: bright);
      }
    }

    Color getSelectedColor() {
      final currnteModel = controller.lightingModel.value;
      if (typeString == "좌측 센터") {
        return currnteModel.leftCenterColor;
      } else if (typeString == "우측 센터") {
        return currnteModel.rightCenterColor;
      } else if (typeString == "좌측 1열 운전석") {
        return currnteModel.leftFirstDriverColor;
      } else if (typeString == "우측 1열 조수석") {
        return currnteModel.rightFirstPassengerColor;
      } else if (typeString == "좌측 2열 운전석") {
        return currnteModel.leftSecondDriverColor;
      } else {
        //우측 2열 조수석
        return currnteModel.rightSecondPassengerColor;
      }
    }

    List<Color> getFavoriteColors() {
      final currnteModel = controller.lightingModel.value;
      if (typeString == "좌측 센터") {
        return currnteModel.leftCenterFavorites;
      } else if (typeString == "우측 센터") {
        return currnteModel.rightCenterFavorites;
      } else if (typeString == "좌측 1열 운전석") {
        return currnteModel.leftFirstDriverFavorites;
      } else if (typeString == "우측 1열 조수석") {
        return currnteModel.rightFirstPassengerFavorites;
      } else if (typeString == "좌측 2열 운전석") {
        return currnteModel.leftSecondDriverFavorites;
      } else {
        //우측 2열 조수석
        return currnteModel.rightSecondPassengerFavorites;
      }
    }

    void onColorChange(Color color) {
      final currnteModel = controller.lightingModel.value;
      if (typeString == "좌측 센터") {
        controller.lightingModel.value =
            currnteModel.copyWith(leftCenterColor: color);
      } else if (typeString == "우측 센터") {
        controller.lightingModel.value =
            currnteModel.copyWith(rightCenterColor: color);
      } else if (typeString == "좌측 1열 운전석") {
        controller.lightingModel.value =
            currnteModel.copyWith(leftFirstDriverColor: color);
      } else if (typeString == "우측 1열 조수석") {
        controller.lightingModel.value =
            currnteModel.copyWith(rightFirstPassengerColor: color);
      } else if (typeString == "좌측 2열 운전석") {
        controller.lightingModel.value =
            currnteModel.copyWith(leftSecondDriverColor: color);
      } else {
        //우측 2열 조수석
        controller.lightingModel.value =
            currnteModel.copyWith(rightSecondPassengerColor: color);
      }
    }

    void selectedSave() {
      final currnteModel = controller.lightingModel.value;
      if (typeString == "좌측 센터") {
        final colors = [
          ...currnteModel.leftCenterFavorites,
          currnteModel.leftCenterColor
        ];
        controller.lightingModel.value =
            currnteModel.copyWith(leftCenterFavorites: colors);
      } else if (typeString == "우측 센터") {
        final colors = [
          ...currnteModel.rightCenterFavorites,
          currnteModel.rightCenterColor
        ];
        controller.lightingModel.value =
            currnteModel.copyWith(rightCenterFavorites: colors);
      } else if (typeString == "좌측 1열 운전석") {
        final colors = [
          ...currnteModel.leftFirstDriverFavorites,
          currnteModel.leftFirstDriverColor
        ];
        controller.lightingModel.value =
            currnteModel.copyWith(leftFirstDriverFavorites: colors);
      } else if (typeString == "우측 1열 조수석") {
        final colors = [
          ...currnteModel.rightFirstPassengerFavorites,
          currnteModel.rightFirstPassengerColor
        ];
        controller.lightingModel.value =
            currnteModel.copyWith(rightFirstPassengerFavorites: colors);
      } else if (typeString == "좌측 2열 운전석") {
        final colors = [
          ...currnteModel.leftSecondDriverFavorites,
          currnteModel.leftSecondDriverColor
        ];
        controller.lightingModel.value =
            currnteModel.copyWith(leftSecondDriverFavorites: colors);
      } else {
        //우측 2열 조수석
        final colors = [
          ...currnteModel.rightSecondPassengerFavorites,
          currnteModel.rightSecondPassengerColor
        ];
        controller.lightingModel.value =
            currnteModel.copyWith(rightSecondPassengerFavorites: colors);
      }
    }

    void selectedRemove() {
      final currnteModel = controller.lightingModel.value;
      if (typeString == "좌측 센터") {
        controller.lightingModel.value.leftCenterFavorites
            .remove(currnteModel.leftCenterColor);
      } else if (typeString == "우측 센터") {
        controller.lightingModel.value.rightCenterFavorites
            .remove(currnteModel.rightCenterColor);
      } else if (typeString == "좌측 1열 운전석") {
        controller.lightingModel.value.leftFirstDriverFavorites
            .remove(currnteModel.leftFirstDriverColor);
      } else if (typeString == "우측 1열 조수석") {
        controller.lightingModel.value.rightFirstPassengerFavorites
            .remove(currnteModel.rightFirstPassengerColor);
      } else if (typeString == "좌측 2열 운전석") {
        controller.lightingModel.value.leftSecondDriverFavorites
            .remove(currnteModel.leftSecondDriverColor);
      } else {
        //우측 2열 조수석
        controller.lightingModel.value.rightSecondPassengerFavorites
            .remove(currnteModel.rightSecondPassengerColor);
      }
    }

    void applyFromLighting(Color color) {
      final currnteModel = controller.lightingModel.value;
      controller.isLightingSaveComplete.value = false;
      if (typeString == "좌측 센터") {
        controller.lightingModel.value =
            currnteModel.copyWith(leftCenterColor: color);
      } else if (typeString == "우측 센터") {
        controller.lightingModel.value =
            currnteModel.copyWith(rightCenterColor: color);
      } else if (typeString == "좌측 1열 운전석") {
        controller.lightingModel.value =
            currnteModel.copyWith(leftFirstDriverColor: color);
      } else if (typeString == "우측 1열 조수석") {
        controller.lightingModel.value =
            currnteModel.copyWith(rightFirstPassengerColor: color);
      } else if (typeString == "좌측 2열 운전석") {
        controller.lightingModel.value =
            currnteModel.copyWith(leftSecondDriverColor: color);
      } else {
        //우측 2열 조수석
        controller.lightingModel.value =
            currnteModel.copyWith(rightSecondPassengerColor: color);
      }
    }

    int getColorStatus() {
      //즐겨찾기에 선택색상 없는 경우-저장하기
      if (!controller.musicColors
          .contains(controller.selectedMusicColor.value)) {
        return 0;
      } else {
        return 2;
      }
    }

    return Scaffold(
      appBar: DefaultAppbar(
        title: typeString ?? "",
        onSave: () async {
          bool res = await controller.saveLighting();
          if (res) {
            Get.back();
            Get.snackbar(
              "",
              ""
                  "저장 완료", // 메시지
              titleText: Text(
                "저장 완료",
                style: TextStyle(color: CarsixColors.white1, fontSize: 18),
              ),
              messageText: Text(
                "$typeString 설정이 저장되었습니다.",
                style: TextStyle(color: CarsixColors.white1, fontSize: 16),
              ),
              // backgroundColor: Colors.black, // Snackbar 배경색
              snackPosition: SnackPosition.BOTTOM, // Snackbar 위치
              maxWidth: MediaQuery.of(context).size.width - 20,
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              duration: Duration(seconds: 2),
            );
          } else {
            Get.snackbar(
              "",
              ""
                  "저장 실패", // 메시지
              titleText: Text(
                "저장 실패",
                style: TextStyle(color: CarsixColors.white1, fontSize: 18),
              ),
              messageText: Text(
                "$typeString 설정이 저장을 실패 했습니다.",
                style: TextStyle(color: CarsixColors.white1, fontSize: 16),
              ),
              // backgroundColor: Colors.black, // Snackbar 배경색
              snackPosition: SnackPosition.BOTTOM, // Snackbar 위치
              maxWidth: MediaQuery.of(context).size.width - 20,
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              duration: Duration(seconds: 2),
            );
          }
        },
        backRoute: 'main',
        // isComplete: controller.isLightingSaveComplete.value,
        initComplete: () async {
          controller.isLightingSaveComplete.value = false;
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 28,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          "${typeString ?? ""} 조명 밝기",
                          style: CarsixTxtStyle.settingTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      Obx(() => CarsixSlider(
                            value: RxDouble(getBright()).value,
                            onChange: onBrightChange,
                          )),
                      Obx(
                        () => FavoriteColorPaper(
                            selectedColor: Rx<Color>(getSelectedColor()).value,
                            onColorChange: onColorChange,
                            onTabColorSelectBtn: () {},
                            colorStatus: getColorStatus(),
                            // selectSave: controller.selectMusicSave,
                            // selectRemove: controller.selectMusicRemove,
                            selectSave: selectedSave,
                            selectRemove: selectedRemove,
                            completed: controller.isLightingSaveComplete.value,
                            favoriteColors: Rx(getFavoriteColors()).value,
                            onTabFavoriteColor:
                                applyFromLighting //controller.applyFromMusics,
                            ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
