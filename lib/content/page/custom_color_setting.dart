import 'package:carsix/const/color.dart';
import 'package:carsix/const/style.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/widget/bar/default_appbar.dart';
import 'package:carsix/widget/paper/favorite_color_paper.dart';
import 'package:carsix/widget/slider/carsix_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomColorSetting extends StatelessWidget {
  const CustomColorSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final BLEController controller = Get.find<BLEController>();
    final String? modeString = Get.parameters['mode'];
    final String? typeString = Get.parameters['type'];
    // print("유효하지 않은 타입>>>$typeString");
    final int mode = int.tryParse(modeString ?? '0') ?? 0;
    double getBright() {
      if (typeString == "bg") {
        return controller.customModeModels[mode].value.bgBright;
      } else if (typeString == "sel1") {
        return controller.customModeModels[mode].value.sel1Bright;
      } else {
        return controller.customModeModels[mode].value.sel2Bright;
      }
    }

    void onChangeBright(double value) {
      if (typeString == "bg") {
        controller.customModeModels[mode].value =
            controller.customModeModels[mode].value.copyWith(bgBright: value);
      } else if (typeString == "sel1") {
        controller.customModeModels[mode].value =
            controller.customModeModels[mode].value.copyWith(sel1Bright: value);
      } else {
        controller.customModeModels[mode].value =
            controller.customModeModels[mode].value.copyWith(sel2Bright: value);
      }
    }

    double getVelocity() {
      if (typeString == "bg") {
        return controller.customModeModels[mode].value.bgVelocity;
      } else if (typeString == "sel1") {
        return controller.customModeModels[mode].value.sel1Velocity;
      } else {
        return controller.customModeModels[mode].value.sel2Velocity;
      }
    }

    void onChangeVelocity(double value) {
      if (typeString == "bg") {
        controller.customModeModels[mode].value =
            controller.customModeModels[mode].value.copyWith(bgVelocity: value);
      } else if (typeString == "sel1") {
        controller.customModeModels[mode].value = controller
            .customModeModels[mode].value
            .copyWith(sel1Velocity: value);
      } else {
        controller.customModeModels[mode].value = controller
            .customModeModels[mode].value
            .copyWith(sel2Velocity: value);
      }
    }

    int getColorStatus() {
      if (typeString == "bg") {
        if (!controller.customModeModels[mode].value.customBgColors.contains(
            controller
                .customModeModels[mode].value.selectedBgCustomColor.value)) {
          return 0;
        } else {
          return 2;
        }
      } else if (typeString == "sel1") {
        if (!controller.customModeModels[mode].value.customSel1Colors.contains(
            controller
                .customModeModels[mode].value.selectedSel1CustomColor.value)) {
          return 0;
        } else {
          return 2;
        }
      } else {
        if (!controller.customModeModels[mode].value.customSel2Colors.contains(
            controller
                .customModeModels[mode].value.selectedSel2CustomColor.value)) {
          return 0;
        } else {
          return 2;
        }
      }
      //즐겨찾기에 선택색상 없는 경우-저장하기
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: InkWell(
      //       onTap: () {
      //         //에러나서 페이지빌드중에 겟백 호출 안되게 함
      //         WidgetsBinding.instance.addPostFrameCallback((_) {
      //           Get.back();
      //         });
      //       },
      //       child: Image.asset('assets/images/nav-arrow-left.png')),
      //   actions: [
      //     InkWell(
      // onTap: () async {
      //   bool res = await controller.saveCustomMode();
      //   if (res) {
      //     Get.snackbar(
      //       "",
      //       ""
      //           "저장 완료", // 메시지
      //       titleText: Text(
      //         "저장 완료",
      //         style: TextStyle(color: CarsixColors.white1, fontSize: 18),
      //       ),
      //       messageText: Text(
      //         "커스텀 모드 ${mode + 1} 설정의 ${typeString == "bg" ? "배경색이" : typeString == "sel1" ? "선택 색상1이" : "선택 색상2가"} 저장되었습니다.",
      //         style: TextStyle(color: CarsixColors.white1, fontSize: 16),
      //       ),
      //       // backgroundColor: Colors.black, // Snackbar 배경색
      //       snackPosition: SnackPosition.BOTTOM, // Snackbar 위치
      //       maxWidth: MediaQuery.of(context).size.width - 20,
      //       margin: EdgeInsets.only(
      //         bottom: 20,
      //       ),
      //       duration: Duration(seconds: 2),
      //     );
      //   } else {
      //     Get.snackbar(
      //       "",
      //       ""
      //           "저장 실패", // 메시지
      //       titleText: Text(
      //         "저장 실패",
      //         style: TextStyle(color: CarsixColors.white1, fontSize: 18),
      //       ),
      //       messageText: Text(
      //         "커스텀 모드가 저장되었습니다.",
      //         style: TextStyle(color: CarsixColors.white1, fontSize: 16),
      //       ),
      //       // backgroundColor: Colors.black, // Snackbar 배경색
      //       snackPosition: SnackPosition.BOTTOM, // Snackbar 위치
      //       maxWidth: MediaQuery.of(context).size.width - 20,
      //       margin: EdgeInsets.only(
      //         bottom: 20,
      //       ),
      //       duration: Duration(seconds: 2),
      //     );
      //   }
      // },
      //       child: Text(
      //         "저장하기",
      //         style: TextStyle(
      //           color: Color(0xFFE60012),
      //           fontSize: 16,
      //           fontWeight: FontWeight.w700,
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       width: 12,
      //     )
      //   ],
      //   title: Text(
      //     "커스텀 모드 ${mode + 1}",
      //     style: TextStyle(
      //       color: CarsixColors.white1,
      //       fontWeight: FontWeight.w700,
      //       fontSize: 16,
      //     ),
      //   ),
      // ),

      appBar: DefaultAppbar(
        title: "커스텀 모드 ${mode + 1}",
        backRoute: "custom-setting",
        onSave: () async {
          bool res = await controller.saveCustomMode();
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
                "커스텀 모드 ${mode + 1} 설정의 ${typeString == "bg" ? "배경색이" : typeString == "sel1" ? "선택 색상1이" : "선택 색상2가"} 저장되었습니다.",
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
                "커스텀 모드가 저장되었습니다.",
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
                          "${typeString == "bg" ? "배경색" : typeString == "sel1" ? "선택 색상1" : "선택 색상2"} 조명 밝기",
                          style: CarsixTxtStyle.settingTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      Obx(() => CarsixSlider(
                            value: RxDouble(getBright()).value,
                            onChange: onChangeBright,
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          "${typeString == "bg" ? "배경색" : typeString == "sel1" ? "선택 색상1" : "선택 색상2"} 조명 속도",
                          style: CarsixTxtStyle.settingTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      Obx(() => CarsixSlider(
                            value: RxDouble(getVelocity()).value,
                            onChange: onChangeVelocity,
                          )),
                      Obx(
                        () => FavoriteColorPaper(
                          selectedColor: typeString == "bg"
                              ? Rx<Color>(controller.customModeModels[mode]
                                      .value.selectedBgCustomColor)
                                  .value
                              : typeString == "sel1"
                                  ? Rx<Color>(controller.customModeModels[mode]
                                          .value.selectedSel1CustomColor)
                                      .value
                                  : Rx<Color>(controller.customModeModels[mode]
                                          .value.selectedSel2CustomColor)
                                      .value,
                          onColorChange: (Color color) {
                            typeString == "bg"
                                ? controller.customModeModels[mode].value =
                                    controller.customModeModels[mode].value
                                        .copyWith(selectedBgCustomColor: color)
                                : typeString == "sel1"
                                    ? controller.customModeModels[mode].value =
                                        controller.customModeModels[mode].value
                                            .copyWith(
                                                selectedSel1CustomColor: color)
                                    : controller.customModeModels[mode].value =
                                        controller.customModeModels[mode].value
                                            .copyWith(
                                                selectedSel2CustomColor: color);
                          },
                          onTabColorSelectBtn: () {},
                          colorStatus: getColorStatus(),
                          selectSave: () {
                            controller.selectCustomSave(mode, typeString ?? "");
                          },
                          selectRemove: () {
                            controller.selectCustomRemove(typeString ?? "");
                          },
                          completed: controller.isCustomSaveComplete.value,
                          favoriteColors: typeString == "bg"
                              ? RxList<Color>(controller
                                  .customModeModels[mode].value.customBgColors)
                              : typeString == "sel1"
                                  ? RxList<Color>(controller
                                      .customModeModels[mode]
                                      .value
                                      .customSel1Colors)
                                  : RxList<Color>(controller
                                      .customModeModels[mode]
                                      .value
                                      .customSel2Colors),
                          onTabFavoriteColor: (Color color) {
                            controller.applyFromCustoms(
                                mode, color, typeString ?? "");
                          },
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
