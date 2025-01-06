import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/widget/card/custom_card.dart';
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
          isSelected:
              RxBool(controller.customModeModels[index].value.apply).value,
          onApply: () {
            // 특정 인덱스의 apply 값을 true로 업데이트
            controller.updateCustomModeApply(index, true);

            // 다른 모든 버튼의 apply 값을 false로 업데이트
            for (int i = 0; i < controller.customModeModels.length; i++) {
              if (i != index) {
                controller.updateCustomModeApply(i, false);
              }
            }
          },
          title: buttonTitles[index],
          onSetting: () {
            // controller.loadCustomMode(index + 1);
            Get.toNamed('/custom-setting',
                parameters: {"mode": index.toString()});
            // 설정 페이지로 이동 (필요 시 구현)
            // Get.toNamed("/active-mode", parameters: {"mode": index.toString()});
          },
          nowApply:
              RxBool(controller.customModeModels[index].value.apply).value,
          isDisable: RxList<Color>(
                      controller.customModeModels[index].value.customBgColors)
                  .isEmpty &&
              RxList<Color>(
                      controller.customModeModels[index].value.customSel1Colors)
                  .isEmpty &&
              RxList<Color>(
                      controller.customModeModels[index].value.customSel2Colors)
                  .isEmpty,
          bgColor: Rx<Color>(controller
                  .customModeModels[index].value.selectedBgCustomColor)
              .value,
          sel1Color: Rx<Color>(controller
                  .customModeModels[index].value.selectedSel1CustomColor)
              .value,
          sel2Color: Rx<Color>(controller
                  .customModeModels[index].value.selectedSel2CustomColor)
              .value,
        ));
  }
}
