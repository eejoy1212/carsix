import 'package:carsix/const/color.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/btn/individual_color_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndividualContent extends StatelessWidget {
  IndividualContent({super.key});
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
                      "개별 색상 ",
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
                  ],
                ),
              ),
              //차 이미지
              Container(
                // padding: EdgeInsets.symmetric(vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Image.asset(
                        themeController.isDarkMode.isTrue
                            ? 'assets/images/car_img_white.png'
                            : 'assets/images/car_img_dark.png',
                        width: 160,
                      ),
                      Positioned(
                          top: 90,
                          left: 10,
                          child: IndividualColorBtn(
                            color: Colors.orange,
                            light: '2',
                          )),
                      Positioned(
                          top: 90,
                          right: 10,
                          child: IndividualColorBtn(
                            color: Colors.cyan,
                            light: '10',
                          )),
                      Positioned(
                          top: 180,
                          left: 0,
                          child: IndividualColorBtn(
                            color: Colors.blue,
                            light: '5',
                          )),
                      Positioned(
                          top: 180,
                          right: 0,
                          child: IndividualColorBtn(
                            color: Colors.greenAccent,
                            light: '7',
                          )),
                      Positioned(
                          top: 260,
                          left: 0,
                          child: IndividualColorBtn(
                            color: Colors.deepPurple,
                            light: '3',
                          )),
                      Positioned(
                          top: 260,
                          right: 0,
                          child: IndividualColorBtn(
                            color: Colors.blueGrey,
                            light: '8',
                          )),
                    ])
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: CarsixColors.grey2),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "전체 밝기  10/10",
                      style: TextStyle(
                        color: CarsixColors.grey2,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // 주석 아래에 슬라이더 배치
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: CarsixColors.primaryRed,
                        inactiveTrackColor: CarsixColors.grey2,
                        thumbColor: CarsixColors.primaryRed,
                        overlayColor: CarsixColors.primaryRed.withOpacity(0.2),
                        valueIndicatorColor: CarsixColors.red2, // 라벨의 배경색 변경
                        valueIndicatorTextStyle: TextStyle(
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
