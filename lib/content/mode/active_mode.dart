import 'package:carsix/const/color.dart';
import 'package:carsix/const/style.dart';
import 'package:carsix/widget/btn/cerymony_btn.dart';
import 'package:carsix/widget/btn/moving_btn.dart';
import 'package:carsix/widget/btn/weather_btn.dart';
import 'package:carsix/widget/card/border_card.dart';
import 'package:carsix/widget/chip/bottom_nav_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ActiveModeContent extends StatelessWidget {
  ActiveModeContent({super.key});
  TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: CarsixColors.white1,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset('assets/images/nav-arrow-left.png')),
          actions: [
            InkWell(
              onTap: () {},
              child: Text(
                "저장하기",
                style: TextStyle(
                  color: Color(0xFFE60012),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: 12,
            )
          ],
          title: Text(
            "액티브 모드 설정",
            style: TextStyle(
              color: CarsixColors.white1,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              // 속도 설정
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
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              //웰컴 세리머니 색상
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "웰컴 세리머니 색상",
                        style: titleStyle,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CerymonyBtn(
                            width: (MediaQuery.of(context).size.width - 66) / 3,
                            title: "웰컴 1",
                            onTap: () {
                              Get.toNamed("/welcome");
                            }),
                        SizedBox(
                          width: 8,
                        ),
                        CerymonyBtn(
                            width: (MediaQuery.of(context).size.width - 66) / 3,
                            title: "웰컴 2",
                            onTap: () {}),
                        SizedBox(
                          width: 8,
                        ),
                        WeatherBtn(
                            width: (MediaQuery.of(context).size.width - 66) / 3,
                            title: "웰컴 2",
                            onTap: () {}),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              //굿바이 세리머니 색상
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "굿바이 세리머니 색상",
                        style: titleStyle,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CerymonyBtn(
                            width: (MediaQuery.of(context).size.width - 66) / 3,
                            title: "굿바이 1",
                            onTap: () {}),
                        SizedBox(
                          width: 8,
                        ),
                        CerymonyBtn(
                            width: (MediaQuery.of(context).size.width - 66) / 3,
                            title: "굿바이 2",
                            onTap: () {}),
                        SizedBox(
                          width: 8,
                        ),
                        CerymonyBtn(
                            width: (MediaQuery.of(context).size.width - 66) / 3,
                            title: "굿바이 3",
                            onTap: () {}),
                      ],
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
