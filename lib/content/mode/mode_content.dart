import 'package:carsix/const/color.dart';
import 'package:carsix/content/tabview/active_tabview.dart';
import 'package:carsix/content/tabview/ceremoney_tabview.dart';
import 'package:carsix/content/tabview/custom_tabview.dart';
import 'package:carsix/content/tabview/music_tabview.dart';
import 'package:carsix/content/tabview/single_color_tabview.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/btn/bright_btn.dart';
import 'package:carsix/widget/indicator/circle_indicatio.dart';
import 'package:carsix/widget/slider/circular_dashed_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
      child: DefaultTabController(
        length: 4, // 탭의 수
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 26),
                      Image.asset(
                        'assets/images/logo_splash.png',
                        width: 40,
                      ),
                      Obx(
                        () => SleekCircularSlider(
                          innerWidget: (percentage) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  percentage.toStringAsFixed(0), // 화면상 퍼센트 표시
                                  style: TextStyle(
                                    fontSize: 48,
                                    color: CarsixColors.white1,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  "%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: CarsixColors.white1,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            );
                          },
                          initialValue:
                              bleController.brightValue.value, // 초기값 0~100%
                          min: 0, // 화면상 최소값
                          max: 100, // 화면상 최대값
                          onChangeEnd: (double value) {
                            double actualBrightness = (value / 100) * 250;
                            bleController.changeBrightness(
                              brightnessValues: [
                                actualBrightness.toInt(),
                                actualBrightness.toInt(),
                                actualBrightness.toInt(),
                                actualBrightness.toInt(),
                                actualBrightness.toInt(),
                                actualBrightness.toInt(),
                                actualBrightness.toInt()
                              ],
                            );
                          },
                          onChange: (double value) {
                            // 화면상의 0~100% 값을 실제 0~250 값으로 변환
                            bleController.brightValue.value = value;
                          },
                          appearance: CircularSliderAppearance(
                            size: 200,
                            customWidths: CustomSliderWidths(
                              trackWidth: 10,
                              progressBarWidth: 26,
                              handlerSize: 8,
                            ),
                            customColors: CustomSliderColors(
                              trackColor: Colors.grey,
                              progressBarColor: CarsixColors.progressRed,
                              dotColor: CarsixColors.black3,
                              shadowColor: CarsixColors.progressRed,
                              shadowStep: 10,
                            ),
                            infoProperties: InfoProperties(
                              mainLabelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                              modifier: (double value) {
                                return '${value.toInt()}%'; // 퍼센트 표시
                              },
                            ),
                          ),
                        ),
                      ),

                      // Obx(
                      //   () => CircularDashedSlider(
                      //     initialValue: bleController.brightValue.value,
                      //     onChange: (value) {
                      //       bleController.brightValue.value = value;
                      //     },
                      //     onChangeEnd: (value) {
                      //       double actualBrightness = (value / 100) * 250;
                      //       bleController.changeBrightness(
                      //         brightnessValues:
                      //             List.filled(7, actualBrightness.toInt()),
                      //       );
                      //     },
                      //   ),
                      // ),

                      SizedBox(height: 22),
                      Text(
                        "밝기 조절",
                        style: TextStyle(
                          color: CarsixColors.white1,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "다이얼을 돌려서 밝기를 조절해주세요.\n자동 밝기 기능은 하단 버튼을 눌러주세요.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CarsixColors.grey7,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 8),
                      BrightBtn(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                TabBar(
                  dividerColor: Colors.transparent,
                  indicator: CircleIndicator(color: CarsixColors.primaryRed),
                  labelColor: themeController.isDarkMode.value
                      ? CarsixColors.white1
                      : CarsixColors.primaryRed,
                  unselectedLabelColor: CarsixColors.grey2,
                  indicatorColor: CarsixColors.primaryRed,
                  tabs: [
                    Tab(
                      height: 60,
                      child: Text(
                        "액티브",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "단색",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      height: 60,
                    ),
                    Tab(
                      child: Text(
                        "뮤직",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      height: 60,
                    ),
                    Tab(
                      child: Text(
                        "커스텀",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      height: 60,
                    ),
                  ],
                  onTap: (index) {
                    print("탭 변경됨: $index");
                    bleController.changeMode(index + 1);
                    // bleController.updateTabIndex(index);
                  },
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ActiveTabView(),
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
      ),
    );
  }
}
