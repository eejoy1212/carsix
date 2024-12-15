import 'package:carsix/const/color.dart';
import 'package:carsix/const/style.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/widget/paper/favorite_color_paper.dart';
import 'package:carsix/widget/slider/carsix_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicSetting extends StatelessWidget {
  const MusicSetting({super.key});

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
                controller.initMusicSetting();
                Get.back();
              });
            },
            child: Image.asset('assets/images/nav-arrow-left.png')),
        actions: [
          InkWell(
            onTap: () async {
              await controller.saveMusicMode(mode + 1);
              Get.snackbar(
                "",
                ""
                    "이것은 메시지입니다.", // 메시지
                titleText: Text(
                  "저장 완료",
                  style: TextStyle(color: CarsixColors.white1, fontSize: 18),
                ),
                messageText: Text(
                  "뮤직 모드 ${mode + 1} 설정이 저장되었습니다.",
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
          "뮤직 모드 ${mode + 1}",
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
                          "뮤직 모드 ${mode + 1} 조명 밝기",
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
                          "뮤직 모드 ${mode + 1} 감도 조절",
                          style: CarsixTxtStyle.settingTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      CarsixSlider(),
                      Obx(
                        () => FavoriteColorPaper(
                          selectedColor: controller.selectedMusicColor.value,
                          onColorChange: (Color color) {
                            controller.selectedMusicColor.value = color;
                          },
                          onTabColorSelectBtn: () {},
                          colorStatus: getColorStatus(),
                          selectSave: controller.selectMusicSave,
                          selectRemove: controller.selectMusicRemove,
                          completed: controller.isMusicSaveComplete.value,
                          favoriteColors: controller.musicColors,
                          onTabFavoriteColor: controller.applyFromMusics,
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
