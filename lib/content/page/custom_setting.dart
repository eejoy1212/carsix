import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/widget/card/border_card.dart';
import 'package:carsix/widget/card/custom_mode_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSetting extends StatelessWidget {
  const CustomSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final BLEController controller = Get.find<BLEController>();
    final String? modeString = Get.parameters['mode'];
    final int mode = int.tryParse(modeString ?? '0') ?? 0;

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              //에러나서 페이지빌드중에 겟백 호출 안되게 함
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // controller.initCustomSetting();
                Get.back();
              });
            },
            child: Image.asset('assets/images/nav-arrow-left.png')),
        actions: [
          InkWell(
            onTap: () async {
              bool res = await controller.saveMusicMode();
              if (res) {
                Get.snackbar(
                  "",
                  ""
                      "저장 완료", // 메시지
                  titleText: Text(
                    "저장 완료",
                    style: TextStyle(color: CarsixColors.white1, fontSize: 18),
                  ),
                  messageText: Text(
                    "커스텀 모드 ${mode + 1} 설정이 저장되었습니다.",
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
                    "커스텀 모드 ${mode + 1} 설정을 실패했습니다.",
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
                    top: 11,
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => _customTileSet(
                          "배경색",
                          mode,
                          controller.customModeModels[mode].value
                              .selectedBgCustomColor)),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() => _customTileSet(
                          "선택 색상 1",
                          mode,
                          controller.customModeModels[mode].value
                              .selectedSel1CustomColor)),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() => _customTileSet(
                          "선택 색상 2",
                          mode,
                          controller.customModeModels[mode].value
                              .selectedSel2CustomColor)),
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

  Widget _customTileSet(String title, int mode, Color selected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              title + " 설정",
              style: TextStyle(
                color: CarsixColors.white1,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        CustomModeCard(
          title: title,
          selected: selected,
          onTap: () {
            var type = "bg";
            if (title == "배경색") {
              type = "bg";
            } else if (title == "선택 색상 1") {
              type = "sel1";
            } else {
              type = "sel2";
            }
            Get.toNamed('/custom-color-setting',
                parameters: {"mode": mode.toString(), "type": type});
          },
        )
      ],
    );
  }
}
