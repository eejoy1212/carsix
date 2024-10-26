import 'package:carsix/const/color.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LedContent extends StatelessWidget {
  LedContent({super.key});
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //타이틀
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  children: [
                    Text(
                      "LED",
                      style: TextStyle(
                          height: 1.6,
                          color: themeController.isDarkMode.value
                              ? CarsixColors.white1
                              : CarsixColors.grey6,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 2),
                    ),
                  ],
                ),
              ),
              //카드1
              Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 16, bottom: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeController.isDarkMode.value
                      ? CarsixColors.grey1
                      : CarsixColors.white2,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  // border: Border.all(color: CarsixColors.grey2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
                      spreadRadius: 2, // 그림자가 퍼지는 정도
                      blurRadius: 5, // 그림자의 흐림 정도
                      offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 80,
                          child: Text(
                            "센터 좌",
                            style: TextStyle(
                              color: CarsixColors.grey2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Switch(
                          value: true, // 스위치 상태
                          onChanged: (bool val) {}, // 스위치 상태 변경 시 호출할 함수
                          activeColor: CarsixColors.red2, // 스위치가 켜졌을 때 색상
                        ),
                      ],
                    ),
                    // 주석 아래에 슬라이더 배치
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
                        value: 10, //controller.musicSensitivity.value,
                        min: 0.0,
                        max: 100.0,
                        divisions: 100,
                        label:
                            '10', //controller.musicSensitivity.value.round().toString(),
                        onChanged: (double value) {
                          // controller.musicSensitivity.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //카드2
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeController.isDarkMode.value
                      ? CarsixColors.grey1
                      : CarsixColors.white2,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  // border: Border.all(color: CarsixColors.grey2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
                      spreadRadius: 2, // 그림자가 퍼지는 정도
                      blurRadius: 5, // 그림자의 흐림 정도
                      offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 80,
                          child: Text(
                            "센터 우",
                            style: TextStyle(
                              color: CarsixColors.grey2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Switch(
                          value: true, // 스위치 상태
                          onChanged: (bool val) {}, // 스위치 상태 변경 시 호출할 함수
                          activeColor: CarsixColors.red2, // 스위치가 켜졌을 때 색상
                        ),
                      ],
                    ),
                    // 주석 아래에 슬라이더 배치
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
                        value: 10, //controller.musicSensitivity.value,
                        min: 0.0,
                        max: 100.0,
                        divisions: 100,
                        label:
                            '10', //controller.musicSensitivity.value.round().toString(),
                        onChanged: (double value) {
                          // controller.musicSensitivity.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeController.isDarkMode.value
                      ? CarsixColors.grey1
                      : CarsixColors.white2,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  // border: Border.all(color: CarsixColors.grey2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
                      spreadRadius: 2, // 그림자가 퍼지는 정도
                      blurRadius: 5, // 그림자의 흐림 정도
                      offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 80,
                          child: Text(
                            "1열 운전석",
                            style: TextStyle(
                              color: CarsixColors.grey2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Switch(
                          value: true, // 스위치 상태
                          onChanged: (bool val) {}, // 스위치 상태 변경 시 호출할 함수
                          activeColor: CarsixColors.red2, // 스위치가 켜졌을 때 색상
                        ),
                      ],
                    ),
                    // 주석 아래에 슬라이더 배치
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
                        value: 10, //controller.musicSensitivity.value,
                        min: 0.0,
                        max: 100.0,
                        divisions: 100,
                        label:
                            '10', //controller.musicSensitivity.value.round().toString(),
                        onChanged: (double value) {
                          // controller.musicSensitivity.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeController.isDarkMode.value
                      ? CarsixColors.grey1
                      : CarsixColors.white2,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  // border: Border.all(color: CarsixColors.grey2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
                      spreadRadius: 2, // 그림자가 퍼지는 정도
                      blurRadius: 5, // 그림자의 흐림 정도
                      offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 80,
                          child: Text(
                            "2열 운전석",
                            style: TextStyle(
                              color: CarsixColors.grey2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Switch(
                          value: true, // 스위치 상태
                          onChanged: (bool val) {}, // 스위치 상태 변경 시 호출할 함수
                          activeColor: CarsixColors.red2, // 스위치가 켜졌을 때 색상
                        ),
                      ],
                    ),
                    // 주석 아래에 슬라이더 배치
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
                        value: 10, //controller.musicSensitivity.value,
                        min: 0.0,
                        max: 100.0,
                        divisions: 100,
                        label:
                            '10', //controller.musicSensitivity.value.round().toString(),
                        onChanged: (double value) {
                          // controller.musicSensitivity.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeController.isDarkMode.value
                      ? CarsixColors.grey1
                      : CarsixColors.white2,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  // border: Border.all(color: CarsixColors.grey2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
                      spreadRadius: 2, // 그림자가 퍼지는 정도
                      blurRadius: 5, // 그림자의 흐림 정도
                      offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 80,
                          child: Text(
                            "2열 조수석",
                            style: TextStyle(
                              color: CarsixColors.grey2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Switch(
                          value: true, // 스위치 상태
                          onChanged: (bool val) {}, // 스위치 상태 변경 시 호출할 함수
                          activeColor: CarsixColors.red2, // 스위치가 켜졌을 때 색상
                        ),
                      ],
                    ),
                    // 주석 아래에 슬라이더 배치
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
                        value: 10, //controller.musicSensitivity.value,
                        min: 0.0,
                        max: 100.0,
                        divisions: 100,
                        label:
                            '10', //controller.musicSensitivity.value.round().toString(),
                        onChanged: (double value) {
                          // controller.musicSensitivity.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeController.isDarkMode.value
                      ? CarsixColors.grey1
                      : CarsixColors.white2,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  // border: Border.all(color: CarsixColors.grey2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
                      spreadRadius: 2, // 그림자가 퍼지는 정도
                      blurRadius: 5, // 그림자의 흐림 정도
                      offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 80,
                          child: Text(
                            "풋 등",
                            style: TextStyle(
                              color: CarsixColors.grey2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Switch(
                          value: true, // 스위치 상태
                          onChanged: (bool val) {}, // 스위치 상태 변경 시 호출할 함수
                          activeColor: CarsixColors.red2, // 스위치가 켜졌을 때 색상
                        ),
                      ],
                    ),
                    // 주석 아래에 슬라이더 배치
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
                        value: 10, //controller.musicSensitivity.value,
                        min: 0.0,
                        max: 100.0,
                        divisions: 100,
                        label:
                            '10', //controller.musicSensitivity.value.round().toString(),
                        onChanged: (double value) {
                          // controller.musicSensitivity.value = value;
                        },
                      ),
                    ),
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
