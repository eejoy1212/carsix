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
      appBar: DefaultAppbar(title: "우측 센터"),
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
                          "우측 센터 조명 밝기",
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
