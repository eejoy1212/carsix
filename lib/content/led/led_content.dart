import 'package:carsix/const/color.dart';
import 'package:carsix/const/style.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/gauge/circular_gauge.dart';
import 'package:carsix/widget/paper/led_status_paper.dart';
import 'package:carsix/widget/slider/carsix_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LedContent extends StatelessWidget {
  LedContent({super.key});
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 50,
                ),
                child: Text(
                  "조명",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/car_topview.svg',
                    width: width - 180,
                  ),
                  // 좌측센터
                  Positioned(
                      top: 70,
                      left: 10,
                      child: LedStatusPaper(
                        onTap: () {
                          Get.toNamed("/led-setting");
                        },
                      )),
                  // 우측 센터
                  Positioned(
                      top: 70,
                      right: 10,
                      child: LedStatusPaper(
                        onTap: () {
                          Get.toNamed("/led-setting");
                        },
                      )),
                  //좌측 1열 운전석
                  Positioned(
                      top: 175,
                      left: 0,
                      child: LedStatusPaper(
                        onTap: () {
                          Get.toNamed("/led-setting");
                        },
                      )),
                  //우측 1열 조수석
                  Positioned(
                      top: 175,
                      right: 0,
                      child: LedStatusPaper(
                        onTap: () {
                          Get.toNamed("/led-setting");
                        },
                      )),
                  //좌측 2열 운전석
                  Positioned(
                      top: 280,
                      left: 0,
                      child: LedStatusPaper(
                        onTap: () {
                          Get.toNamed("/led-setting");
                        },
                      )),
                  //우측 2열 조수석
                  Positioned(
                      top: 280,
                      right: 0,
                      child: LedStatusPaper(
                        onTap: () {
                          Get.toNamed("/led-setting");
                        },
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 28,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Text(
                        "속도 설정",
                        style: CarsixTxtStyle.settingTitleStyle,
                      ),
                    ),
                    SizedBox(
                      height: 38,
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        // thumbShape: SliderComponentShape.noOverlay,

                        activeTrackColor: CarsixColors.primaryRed,
                        inactiveTrackColor: CarsixColors.primaryRed
                            .withOpacity(0.2), //CarsixColors.grey2,
                        thumbColor: CarsixColors.white1,
                        overlayColor: CarsixColors.primaryRed.withOpacity(0.2),
                        valueIndicatorColor:
                            CarsixColors.primaryRed, // 라벨의 배경색 변경
                        valueIndicatorTextStyle: TextStyle(
                          color: CarsixColors.white1, // 라벨의 글자색 변경
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
