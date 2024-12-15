import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/widget/card/active_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';

class ActiveTabView extends StatelessWidget {
  final MainController controller = Get.find<MainController>();
  final BLEController bleController = Get.find<BLEController>();
  @override
  Widget build(BuildContext context) {
    final List<String> buttonTitles = [
      "레인보우",
      "액티브 모드 1",
      "액티브 모드 2",
      "액티브 모드 3",
      "액티브 모드 4",
      "액티브 모드 5",
      "액티브 모드 6",
      "액티브 모드 7",
      "액티브 모드 8",
      "액티브 모드 9",
      "액티브 모드 10",
      "액티브 모드 11",
    ];

    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Column(
                children: List.generate(6, (index) {
                  int firstButtonIndex = index * 2;
                  int secondButtonIndex = firstButtonIndex + 1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(() => ActiveCard(
                                isSelected:
                                    bleController.selectedButtonIndex.value ==
                                        firstButtonIndex,
                                // color: bleController.selectedButtonIndex.value ==
                                //         firstButtonIndex
                                //     ? CarsixColors.primaryRed
                                //     : CarsixColors.grey1,
                                onApply: () {
                                  bleController.selectedButtonIndex.value =
                                      firstButtonIndex;
                                  // if (firstButtonIndex == 0) {
                                  //   // 레인보우 모드 버튼 기능
                                  //   bleController
                                  //       .testSendLEDCountConfigExample1();
                                  // } else {
                                  //   // 액티브 모드 버튼 기능
                                  //   bleController
                                  //       .sendActiveModeToBLE(firstButtonIndex);
                                  // }
                                  // bleController.testSetStrip1LEDCount();
                                  // bleController.sendActiveMode1();
                                },
                                title: buttonTitles[firstButtonIndex],
                                onSetting: () {
                                  Get.toNamed("/active-mode", parameters: {
                                    "mode": firstButtonIndex.toString()
                                  }); // mode를 URL에 추가
                                },
                                nowApply:
                                    bleController.selectedButtonIndex.value ==
                                        firstButtonIndex,
                              )),
                        ),
                        if (secondButtonIndex < buttonTitles.length) ...[
                          SizedBox(width: 20),
                          Expanded(
                            child: Obx(() => ActiveCard(
                                  isSelected:
                                      bleController.selectedButtonIndex.value ==
                                          secondButtonIndex,
                                  onApply: () {
                                    bleController.selectedButtonIndex.value =
                                        secondButtonIndex;
                                    // if (secondButtonIndex == 0) {
                                    //   // 레인보우 모드 버튼 기능
                                    //   bleController.sendRainbowToBLE();
                                    // } else {
                                    //   // 액티브 모드 버튼 기능
                                    //   bleController.sendActiveModeToBLE(
                                    //       secondButtonIndex);
                                    // }
                                  },
                                  title: buttonTitles[secondButtonIndex],
                                  onSetting: () {
                                    Get.toNamed("/active-mode", parameters: {
                                      "mode": secondButtonIndex.toString()
                                    }); // mode를 URL에 추가
                                  },
                                  nowApply:
                                      bleController.selectedButtonIndex.value ==
                                          secondButtonIndex,
                                )),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              ),
              SizedBox(height: 96)
            ],
          ),
        ),
      ),
    );
  }
}
