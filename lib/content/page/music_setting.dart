import 'package:carsix/const/color.dart';
import 'package:carsix/const/style.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/models/music_mode_model.dart';
import 'package:carsix/widget/bar/default_appbar.dart';
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
      // final currentModel = controller.musicModeModel[mode].value;
      //즐겨찾기에 선택색상 없는 경우-저장하기
      if (!controller.musicModeModel[mode].value.musicColors
          .contains(controller.musicModeModel[mode].value.selectedMusicColor)) {
        return 0;
      } else {
        return 2;
      }
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: InkWell(
      //       onTap: () {
      //         //에러나서 페이지빌드중에 겟백 호출 안되게 함
      //         WidgetsBinding.instance.addPostFrameCallback((_) {
      //           // controller.initMusicSetting();
      //           Get.back();
      //         });
      //       },
      //       child: Image.asset('assets/images/nav-arrow-left.png')),
      //   actions: [
      //     InkWell(
      // onTap: () async {
      //   bool res = await controller.saveMusicMode();
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
      //         "뮤직 모드 ${mode + 1} 설정이 저장되었습니다.",
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
      //         "뮤직 모드 ${mode + 1} 설정을 실패했습니다.",
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
      //     "뮤직 모드 ${mode + 1}",
      //     style: TextStyle(
      //       color: CarsixColors.white1,
      //       fontWeight: FontWeight.w700,
      //       fontSize: 16,
      //     ),
      //   ),
      // ),

      appBar: DefaultAppbar(
        title: "뮤직 모드 ${mode + 1}",
        backRoute: "main",
        onSave: () async {
          bool res = await controller.saveMusicMode();
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
                "뮤직 모드 ${mode + 1} 설정을 실패했습니다.",
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
                          "뮤직 모드 ${mode + 1} 조명 밝기",
                          style: CarsixTxtStyle.settingTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      Obx(() => CarsixSlider(
                            value: controller
                                .musicModeModel[mode].value.musicBright,
                            onChange: (double value) {
                              controller.updateMusicModeBright(mode, value);
                            },
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
                          "뮤직 모드 ${mode + 1} 감도 조절",
                          style: CarsixTxtStyle.settingTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      // CarsixSlider(),
                      Obx(
                        () => FavoriteColorPaper(
                          selectedColor: controller
                              .musicModeModel[mode].value.selectedMusicColor,
                          onColorChange: (Color color) {
                            final currentModel =
                                controller.musicModeModel[mode].value;

                            // 기존 모델 객체를 copyWith로 수정
                            final updatedModel = currentModel.copyWith(
                                selectedMusicColor: color);

                            // 수정된 모델을 다시 할당
                            controller.musicModeModel[mode].value =
                                updatedModel;
                          },
                          onTabColorSelectBtn: () {},
                          colorStatus: Rx(getColorStatus()).value,
                          selectSave: () {
                            controller.selectMusicSave(mode);
                          },
                          selectRemove: () {
                            controller.selectMusicRemove(mode);
                          },
                          completed: controller.isMusicSaveComplete.value,
                          favoriteColors:
                              controller.musicModeModel[mode].value.musicColors,
                          onTabFavoriteColor: (Color color) {
                            controller.applyFromMusics(color, mode);
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
