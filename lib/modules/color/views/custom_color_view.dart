import 'package:carsix/const/color.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomColorView extends StatelessWidget {
  CustomColorView({super.key});
  final MainController controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "커스텀 모드 배경색 설정",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                    controller.addToMusics(color); // 선택된 색상을 즐겨찾기에 추가
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
              // 즐겨찾기 색상 표시 및 제거 기능 추가
              Obx(
                () => Wrap(
                  spacing: 5,
                  children: controller.musicColors
                      .map(
                        (color) => GestureDetector(
                          onTap: () {
                            controller.removeFromMusics(color);
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
                  '즐겨찾기 색상: ${controller.musicColors.length}/1',
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
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      child: RedBtn(
                        height: 46,
                        onPressed: () {},
                        title: Text(
                          "확인",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
