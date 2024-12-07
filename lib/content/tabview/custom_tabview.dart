import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabView extends StatelessWidget {
  CustomTabView({super.key});
  final BLEController controller = Get.find<BLEController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Obx(
              () => ColorPicker(
                color: controller.selectedCustomColor.value, // 선택된 색상
                onColorChanged: (Color color) {
                  controller.selectedCustomColor.value = color; // 색상 업데이트
                },
                onColorChangeEnd: (Color color) {
                  if (controller.isCustomBg.isTrue) {
                    controller.customBgColor.value = color;
                  } else {
                    if (controller.customBlockColors.length == 2) {
                      return;
                    } else {
                      controller.customBlockColors.add(color);
                    }
                  }
                  // controller.addToSingleColors(color); // 선택된 색상을 즐겨찾기에 추가
                },
                subheading: const Text(
                  '사용할 색상 선택',
                  style: TextStyle(
                    color: CarsixColors.grey2,
                    fontSize: 14,
                  ),
                ),
                showColorName: true,
                pickersEnabled: const <ColorPickerType, bool>{
                  ColorPickerType.wheel: true,
                },
              ),
            ),
            Divider(),
            Container(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    controller.isCustomBg.value = true;
                  },
                  child: Row(
                    children: [
                      Obx(() => Icon(
                            Icons.check,
                            color: controller.isCustomBg.isTrue
                                ? Colors.white
                                : Colors.transparent,
                          )),
                      Text("배경색 선택하기"),
                    ],
                  )),
            ),
            Obx(
              () => Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: controller.customBgColor.value,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Divider(),
            Container(
              width: 300,
              child: ElevatedButton(
                  onPressed: () {
                    controller.isCustomBg.value = false;
                  },
                  child: Row(
                    children: [
                      Obx(() => Icon(
                            Icons.check,
                            color: controller.isCustomBg.isFalse
                                ? Colors.white
                                : Colors.transparent,
                          )),
                      Text("Block1, Block2 선택하기"),
                    ],
                  )),
            ),
            Obx(() => Row(
                children: controller.customBlockColors
                    .map(
                      (color) => Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                    .toList())),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: RedBtn(
                      onPressed: () {
                        if (controller.customBlockColors.length < 2) {
                          return;
                        } else {
                          // BLE 명령 호출
                          controller.changeCustomModeColor(
                            backgroundRed: controller.customBgColor.value.red,
                            backgroundGreen:
                                controller.customBgColor.value.green,
                            backgroundBlue: controller.customBgColor.value.blue,
                            block1Red: controller.customBlockColors[0].red,
                            block1Green: controller.customBlockColors[0].green,
                            block1Blue: controller.customBlockColors[0].blue,
                            block2Red: controller.customBlockColors[1].red,
                            block2Green: controller.customBlockColors[1].green,
                            block2Blue: controller.customBlockColors[1].blue,
                          );
                        }
                      },
                      title: Text(
                        "이 설정 적용하기",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
