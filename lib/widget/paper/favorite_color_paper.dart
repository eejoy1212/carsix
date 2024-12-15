import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/widget/btn/color_select_btn.dart';
import 'package:carsix/widget/chip/selected_color_chip.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteColorPaper extends StatelessWidget {
  final void Function(Color) onColorChange;
  final Color selectedColor;
  final void Function() onTabColorSelectBtn;
  final void Function() selectSave;
  final void Function() selectRemove;
  final int colorStatus;
  final bool completed;
  final List<Color> favoriteColors;
  final void Function(Color) onTabFavoriteColor;
  const FavoriteColorPaper(
      {super.key,
      required this.selectedColor,
      required this.onColorChange,
      required this.onTabColorSelectBtn,
      required this.colorStatus,
      required this.selectSave,
      required this.selectRemove,
      required this.completed,
      required this.favoriteColors,
      required this.onTabFavoriteColor});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BLEController>();
    int getColorStatus() {
      return 0;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 색상 선택기
          ColorPicker(
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
            color: selectedColor, // 선택된 색상
            onColorChanged: onColorChange,
            onColorChangeEnd: onColorChange,
            onColorChangeStart: onColorChange,

            // subheading: const Text(
            //   '사용할 색상 선택',
            //   style: TextStyle(
            //     color: CarsixColors.grey2,
            //     fontSize: 14,
            //   ),
            // ),
            showColorName: true,
          ),
          const SizedBox(height: 20),
          ColorSelectBtn(
            selected: selectedColor,
            onTab: colorStatus == 0 ? selectSave : selectRemove,
            status: colorStatus,
            completed: completed,
          ),
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
                    child: favoriteColors.isEmpty
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
                            children: favoriteColors
                                .map(
                                  (color) => GestureDetector(
                                    onTap: () {
                                      onTabFavoriteColor(color);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: color,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              selectedColor.value == color.value
                                                  ? Colors.white
                                                  : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      child: selectedColor.value == color.value
                                          ? SelectedColorChip()
                                          : Container(),
                                    ),
                                  ),
                                )
                                .toList(),
                          ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
