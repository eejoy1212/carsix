import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/widget/btn/color_select_btn.dart';
import 'package:carsix/widget/chip/selected_color_chip.dart';
import 'package:carsix/widget/paper/favorite_color_paper.dart';
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
      if (!controller.singleModeModel.value.favoriteColors
          .contains(controller.singleModeModel.value.selectedColor)) {
        return 0;
      } else {
        return 2;
      }
    }

    void selectSave() {
      final currentModel = controller.singleModeModel.value;

      // 선택된 색상이 즐겨찾기에 없을 경우 추가
      if (!currentModel.favoriteColors.contains(currentModel.selectedColor)) {
        final updatedFavorites = List<Color>.from(currentModel.favoriteColors)
          ..add(currentModel.selectedColor);

        controller.singleModeModel.value =
            currentModel.copyWith(favoriteColors: updatedFavorites);
      } else {}
    }

    void onTabFavoriteColor(Color color) {
      final currentModel = controller.singleModeModel.value;
      controller.singleModeModel.value =
          currentModel.copyWith(selectedColor: color);
    }

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Obx(() => FavoriteColorPaper(
                  selectedColor: controller.singleModeModel.value.selectedColor,
                  onColorChange: (Color color) {
                    final currentModel = controller.singleModeModel.value;
                    controller.singleModeModel.value =
                        currentModel.copyWith(selectedColor: color);
                  },
                  onTabColorSelectBtn: () {},
                  colorStatus: getColorStatus(),
                  selectSave: selectSave,
                  selectRemove: () {},
                  completed: controller.isSingleSaveComplete.value,
                  favoriteColors:
                      controller.singleModeModel.value.favoriteColors,
                  onTabFavoriteColor: onTabFavoriteColor)),
            ),
          ],
        ),
      ),
    );
  }
}
