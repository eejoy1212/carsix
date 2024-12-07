import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/modules/favorite/controllers/favorite_controller.dart';
import 'package:carsix/widget/btn/favorite_color_btn.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:carsix/widget/card/selected_favorite_card.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleColorTabView extends StatelessWidget {
  const SingleColorTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final BLEController controller = Get.find<BLEController>();
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FavoriteColorBtn(),
            // SelectedFavoriteCard(title: "title", content: "content"),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 색상 선택기
                  Obx(
                    () => ColorPicker(
                      color: controller.selectedColor.value, // 선택된 색상
                      onColorChanged: (Color color) {
                        controller.isApplySingleColor.value = true;
                        controller.selectedColor.value = color; // 색상 업데이트
                      },
                      onColorChangeEnd: (Color color) {
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

                  const Divider(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: RedBtn(
                              onPressed: () {
                                if (controller.isApplySingleColor.isTrue) {
                                  controller.addToSingleColors(
                                      controller.selectedColor.value);
                                } else {
                                  controller.removeFromSingles(
                                      controller.toApplySingleColor.value);
                                }
                              },
                              title: Row(
                                children: [
                                  Obx(
                                    () => Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            controller.isApplySingleColor.isTrue
                                                ? controller.selectedColor.value
                                                : controller
                                                    .toApplySingleColor.value,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Obx(() => Text(
                                        controller.isApplySingleColor.isTrue
                                            ? "선택 색상 저장하기"
                                            : "저장된 색상 삭제하기",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                  // 즐겨찾기 색상 표시 및 제거 기능 추가
                  Obx(
                    () => Wrap(
                      spacing: 10,
                      children: controller.singleColors
                          .map(
                            (color) => GestureDetector(
                              onTap: () {
                                controller.isApplySingleColor.value = false;
                                // controller
                                //     .removeFromSingles(color); // 클릭 시 즐겨찾기에서 제거
                                controller.applyFromSingles(color);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: controller.toApplySingleColor.value
                                                .value ==
                                            color.value
                                        ? Colors.white
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.check, // 삭제 아이콘 추가
                                  color: controller
                                              .toApplySingleColor.value.value ==
                                          color.value
                                      ? Colors.white
                                      : Colors.transparent,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Obx(
                    () => Text(
                      '즐겨찾기 색상: ${controller.singleColors.length}/6',
                      style: const TextStyle(
                        color: CarsixColors.grey2,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: RedBtn(
                            onPressed: () {
                              final Color selectedColor =
                                  controller.toApplySingleColor.value;

                              // RGB 값 추출
                              int red = selectedColor.red;
                              int green = selectedColor.green;
                              int blue = selectedColor.blue;

                              // BLE 명령 호출
                              controller.changeSingleColorMode(
                                  red: red, green: green, blue: blue);
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
          ],
        ),
      ),
    );
  }
}
