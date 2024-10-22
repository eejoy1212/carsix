import 'package:carsix/const/color.dart';
import 'package:carsix/modules/favorite/controllers/favorite_controller.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({super.key});
  final FavoriteController controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "단색 즐겨찾기 설정",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 색상 선택기
            Obx(
              () => ColorPicker(
                color: controller.selectedColor.value, // 선택된 색상
                onColorChanged: (Color color) {
                  controller.selectedColor.value = color; // 색상 업데이트
                },
                onColorChangeEnd: (Color color) {
                  controller.addToFavorites(color); // 선택된 색상을 즐겨찾기에 추가
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
            const SizedBox(height: 20),
            // 즐겨찾기 색상 표시 및 제거 기능 추가
            Obx(
              () => Wrap(
                spacing: 10,
                children: controller.favoriteColors
                    .map(
                      (color) => GestureDetector(
                        onTap: () {
                          controller
                              .removeFromFavorites(color); // 클릭 시 즐겨찾기에서 제거
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.clear, // 삭제 아이콘 추가
                            color: Colors.white,
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
                '즐겨찾기 색상: ${controller.favoriteColors.length}/6',
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
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: RedBtn(
                      onPressed: () {},
                      title: Text(
                        "확인",
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
