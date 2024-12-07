import 'package:carsix/const/color.dart';
import 'package:carsix/content/tabview/active_tabview.dart';
import 'package:carsix/content/tabview/ceremoney_tabview.dart';
import 'package:carsix/content/tabview/custom_tabview.dart';
import 'package:carsix/content/tabview/music_tabview.dart';
import 'package:carsix/content/tabview/single_color_tabview.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModeContent extends StatelessWidget {
  ModeContent({super.key});
  final themeController = Get.find<ThemeController>();
  final BLEController bleController = Get.find<BLEController>();
  void showBrightnessDialog(BuildContext context) {
    bool isAutoBrightnessOn = true; // 초기값 설정
    double brightnessLevel = 50; // 초기 밝기 설정

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // 상태 관리를 위해 StatefulBuilder 사용
          builder: (context, setState) {
            return AlertDialog(
              title: Text("자동 밝기 설정"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 자동 밝기 스위치
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "자동 밝기 사용",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Switch(
                        activeColor: CarsixColors.red2,
                        value: isAutoBrightnessOn,
                        onChanged: (bool value) {
                          setState(() {
                            isAutoBrightnessOn = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // 밝기 조절 슬라이더

                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: CarsixColors.primaryRed,
                      inactiveTrackColor: CarsixColors.grey2,
                      thumbColor: CarsixColors.primaryRed,
                      overlayColor: CarsixColors.primaryRed.withOpacity(0.2),
                      valueIndicatorColor: CarsixColors.red2, // 라벨의 배경색 변경
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.black, // 라벨의 글자색 변경
                        fontSize: 16,
                      ),
                    ),
                    child: Slider(
                      value: brightnessLevel,
                      min: 0.0,
                      max: 100.0,
                      divisions: 100,
                      label: brightnessLevel.round().toString(),
                      onChanged: isAutoBrightnessOn
                          ? (double value) {
                              setState(() {
                                brightnessLevel = value;
                              });
                            }
                          : null, // 자동 밝기가 꺼져 있으면 슬라이더 비활성화
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("확인"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: DefaultTabController(
          length: 4, // 탭의 수

          child: Column(
            children: [
              // 어떤 탭인지 타이틀
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "모드 설정",
                      style: TextStyle(
                        height: 1.6,
                        color: themeController.isDarkMode.value
                            ? CarsixColors.white1
                            : CarsixColors.grey6,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2.6,
                      ),
                    ),
                    IconButton(
                      onPressed: () => showBrightnessDialog(context),
                      icon: Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            size: 24,
                            color: themeController.isDarkMode.value
                                ? CarsixColors.white1
                                : CarsixColors.grey6,
                          ),
                          SizedBox(width: 10),
                          Text("자동 밝기 (2/10)"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // 탭바 추가
              TabBar(
                labelColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.primaryRed,
                unselectedLabelColor: CarsixColors.grey2,
                indicatorColor: CarsixColors.primaryRed,
                tabs: const [
                  Tab(text: "액티브"),
                  // Tab(text: "세리머니"),
                  Tab(text: "단색"),
                  Tab(text: "뮤직"),
                  Tab(text: "커스텀"),
                ],
                onTap: (index) {
                  print("탭 변경됨: $index");
                  if (index == 0) {
                    print("액티브 탭 선택됨");
                  } else if (index == 1) {
                    print("단색 탭 선택됨");
                  } else if (index == 2) {
                    print("뮤직 탭 선택됨");
                  } else if (index == 3) {
                    print("커스텀 탭 선택됨");
                  }
                  bleController.changeMode(index + 1);
                },
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ActiveTabView(),
                    // CeremonyTabView(),
                    SingleColorTabView(),
                    MusicTabView(),
                    CustomTabView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
