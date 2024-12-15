import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:carsix/widget/card/active_card.dart';
import 'package:carsix/widget/card/custom_card.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabView extends StatelessWidget {
  CustomTabView({super.key});
  final BLEController controller = Get.find<BLEController>();
  final List<String> buttonTitles = [
    "커스텀 모드 1",
    "커스텀 모드 2",
    "커스텀 모드 3",
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: List.generate(
              buttonTitles.length,
              (int idx) => Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: _buildActiveCard(idx)),
            ),
          ),
        ),
      ),
    );
  }

  /// ActiveCard를 만드는 함수
  Widget _buildActiveCard(int index) {
    String getMode() {
      if (index == 0) {
        return "bg";
      } else if (index == 1) {
        return "sel1";
      } else {
        return "sel2";
      }
    }

    return Obx(() => CustomCard(
          titleAlign: MainAxisAlignment.start,
          isSelected: controller.selectedMusicButtonIndex.value == index,
          onApply: () {
            controller.nowApplyCustomMode.value = getMode();
          },
          title: buttonTitles[index],
          onSetting: () {
            controller.loadCustomMode(index + 1);
            Get.toNamed('/custom-setting',
                parameters: {"mode": index.toString()});
            // 설정 페이지로 이동 (필요 시 구현)
            // Get.toNamed("/active-mode", parameters: {"mode": index.toString()});
          },
          nowApply: controller.nowApplyCustomMode.value == getMode(),
          isDisable: getMode() == "bg"
              ? controller.customBgColors.isEmpty
              : getMode() == "sel1"
                  ? controller.customSel1Colors.isEmpty
                  : controller.customSel2Colors.isEmpty,
        ));
  }
}
