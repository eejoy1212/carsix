import 'package:carsix/const/color.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveTabView extends StatelessWidget {
  ActiveTabView({super.key});

  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    // 버튼 이름 리스트
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
                          child: Obx(() => RedBtn(
                                color: controller.selectedButtonIndex.value ==
                                        firstButtonIndex
                                    ? CarsixColors.primaryRed
                                    : CarsixColors.grey1,
                                onPressed: () {
                                  // 선택된 버튼 인덱스를 토글
                                  controller.selectedButtonIndex.value =
                                      controller.selectedButtonIndex.value ==
                                              firstButtonIndex
                                          ? -1
                                          : firstButtonIndex;
                                },
                                title: Text(
                                  buttonTitles[firstButtonIndex],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: CarsixColors.white1,
                                  ),
                                ),
                              )),
                        ),
                        if (secondButtonIndex < buttonTitles.length) ...[
                          SizedBox(width: 20),
                          Expanded(
                            child: Obx(() => RedBtn(
                                  color: controller.selectedButtonIndex.value ==
                                          secondButtonIndex
                                      ? CarsixColors.primaryRed
                                      : CarsixColors.grey1,
                                  onPressed: () {
                                    // 선택된 버튼 인덱스를 토글
                                    controller.selectedButtonIndex.value =
                                        controller.selectedButtonIndex.value ==
                                                secondButtonIndex
                                            ? -1
                                            : secondButtonIndex;
                                  },
                                  title: Text(
                                    buttonTitles[secondButtonIndex],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: CarsixColors.white1,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity, // 버튼을 가로로 꽉 차게 설정
                child: RedBtn(
                  onPressed: () {},
                  title: Text(
                    "저장",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: CarsixColors.white1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
