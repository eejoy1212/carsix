import 'package:carsix/const/color.dart';
import 'package:carsix/const/style.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
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
    print("유효하지 않은 타입>>>$typeString");
    final int mode = int.tryParse(modeString ?? '0') ?? 0;

    int getColorStatus() {
      if (typeString == "bg") {
        if (!controller.customBgColors
            .contains(controller.selectedBgCustomColor.value)) {
          return 0;
        } else {
          return 2;
        }
      } else if (typeString == "sel1") {
        if (!controller.customSel1Colors
            .contains(controller.selectedSel1CustomColor.value)) {
          return 0;
        } else {
          return 2;
        }
      } else {
        if (!controller.customSel2Colors
            .contains(controller.selectedSel2CustomColor.value)) {
          return 0;
        } else {
          return 2;
        }
      }
      //즐겨찾기에 선택색상 없는 경우-저장하기
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              //에러나서 페이지빌드중에 겟백 호출 안되게 함
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.back();
              });
            },
            child: Image.asset('assets/images/nav-arrow-left.png')),
        actions: [
          InkWell(
            onTap: () async {
              controller.saveCustomMode(mode + 1, typeString ?? "");
              Get.snackbar(
                "",
                ""
                    "이것은 메시지입니다.", // 메시지
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
            },
            child: Text(
              "저장하기",
              style: TextStyle(
                color: Color(0xFFE60012),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          )
        ],
        title: Text(
          "커스텀 모드 ${mode + 1}",
          style: TextStyle(
            color: CarsixColors.white1,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
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
                      CarsixSlider(),
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
                      CarsixSlider(),
                      Obx(
                        () => FavoriteColorPaper(
                          selectedColor: typeString == "bg"
                              ? controller.selectedBgCustomColor.value
                              : typeString == "sel1"
                                  ? controller.selectedSel1CustomColor.value
                                  : controller.selectedSel2CustomColor.value,
                          onColorChange: (Color color) {
                            typeString == "bg"
                                ? controller.selectedBgCustomColor.value = color
                                : typeString == "sel1"
                                    ? controller.selectedSel1CustomColor.value =
                                        color
                                    : controller.selectedSel2CustomColor.value =
                                        color;
                          },
                          onTabColorSelectBtn: () {},
                          colorStatus: getColorStatus(),
                          selectSave: () {
                            controller.selectCustomSave(typeString ?? "");
                          },
                          selectRemove: () {
                            controller.selectCustomRemove(typeString ?? "");
                          },
                          completed: controller.isCustomSaveComplete.value,
                          favoriteColors: typeString == "bg"
                              ? controller.customBgColors
                              : typeString == "sel1"
                                  ? controller.customSel1Colors
                                  : controller.customSel2Colors,
                          onTabFavoriteColor: (Color color) {
                            controller.applyFromCustoms(
                                color, typeString ?? "");
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
