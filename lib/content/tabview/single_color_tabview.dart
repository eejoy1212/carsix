import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/modules/favorite/controllers/favorite_controller.dart';
import 'package:carsix/widget/btn/color_select_btn.dart';
import 'package:carsix/widget/btn/favorite_color_btn.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:carsix/widget/card/selected_favorite_card.dart';
import 'package:carsix/widget/chip/selected_color_chip.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleColorTabView extends StatelessWidget {
  const SingleColorTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final BLEController controller = Get.find<BLEController>();
    int getColorStatus() {
      //즐겨찾기에 선택색상 없는 경우-저장하기
      if (!controller.singleColors.contains(controller.selectedColor.value)) {
        return 0;
      } else {
        return 2;
      }
    }

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
                      wheelDiameter: 300,
                      wheelSquareBorderRadius: 16,
                      wheelSquarePadding: 30,
                      wheelWidth: 36,
                      pickersEnabled: const <ColorPickerType, bool>{
                        ColorPickerType.wheel: true, // 휠 활성화
                        ColorPickerType.accent: false, // 비활성화
                        ColorPickerType.primary: false, // 비활성화
                      },
                      enableTonalPalette: false,
                      enableShadesSelection: false,
                      colorNameTextStyle: TextStyle(color: Colors.transparent),
                      color: controller.selectedColor.value, // 선택된 색상
                      onColorChanged: (Color color) {
                        controller.isSingleSaveComplete.value = false;
                        controller.isApplySingleColor.value = true;
                        controller.selectedColor.value = color; // 색상 업데이트
                      },
                      onColorChangeEnd: (Color color) {
                        // controller.selectedColor.value = color;
                        // controller.addToSingleColors(color); // 선택된 색상을 즐겨찾기에 추가
                      },
                      onColorChangeStart: (Color color) {
                        // controller.selectedColor.value = color;
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
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Container(
                  //         margin: EdgeInsets.symmetric(
                  //             horizontal: 20, vertical: 20),
                  //         child: RedBtn(
                  //             onPressed: () {
                  //               if (controller.isApplySingleColor.isTrue) {
                  //                 controller.addToSingleColors(
                  //                     controller.selectedColor.value);
                  //               } else {
                  //                 controller.removeFromSingles(
                  //                     controller.toApplySingleColor.value);
                  //               }
                  //             },
                  //             title: Row(
                  //               children: [
                  //                 Obx(
                  //                   () => Container(
                  //                     width: 40,
                  //                     height: 40,
                  //                     decoration: BoxDecoration(
                  //                       color:
                  //                           controller.isApplySingleColor.isTrue
                  //                               ? controller.selectedColor.value
                  //                               : controller
                  //                                   .toApplySingleColor.value,
                  //                       shape: BoxShape.circle,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Obx(() => Text(
                  //                       controller.isApplySingleColor.isTrue
                  //                           ? "선택 색상 저장하기"
                  //                           : "저장된 색상 삭제하기",
                  //                       style: TextStyle(
                  //                           fontSize: 16,
                  //                           fontWeight: FontWeight.w600),
                  //                     )),
                  //               ],
                  //             )),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Obx(() => ColorSelectBtn(
                        selected: controller.selectedColor.value,
                        onTab: getColorStatus() == 0
                            ? controller.selectSave
                            : controller.selectRemove,
                        status: getColorStatus(),
                        completed: controller.isSingleSaveComplete.value,
                      )),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "색상 즐겨찾기",
                          style: TextStyle(
                            color: Color(0xFF868687),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 30,
                          height: 80,
                          child: Obx(() => controller.singleColors.isEmpty
                              ? Center(
                                  child: Text(
                                    "저장한 색상이 없습니다.",
                                    style: TextStyle(
                                      color: CarsixColors.white1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              : Wrap(
                                  spacing: 18,
                                  runSpacing: 7,
                                  children: controller.singleColors
                                      .map(
                                        (color) => GestureDetector(
                                          onTap: () {
                                            controller.isApplySingleColor
                                                .value = false;
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
                                                color: controller.selectedColor
                                                            .value.value ==
                                                        color.value
                                                    ? Colors.white
                                                    : Colors.transparent,
                                                width: 2,
                                              ),
                                            ),
                                            child: controller.selectedColor
                                                        .value.value ==
                                                    color.value
                                                ? SelectedColorChip()
                                                : Container(),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
