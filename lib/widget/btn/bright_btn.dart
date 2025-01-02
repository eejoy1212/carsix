import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrightBtn extends StatelessWidget {
  BrightBtn({super.key});
  final BLEController bleController = Get.find<BLEController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print("자동밝기 버튼 클릭");
          bleController.isAutoBright.value = !bleController.isAutoBright.value;
          if (bleController.isAutoBright.isTrue) {
            bleController.brightValue.value = 100;
          } else {
            bleController.brightValue.value = 0;
          }
          double actualBrightness =
              (bleController.brightValue.value / 100) * 250;
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
        child: Obx(
          () => Container(
              width: 140,
              padding: EdgeInsets.only(left: 8, right: 12),
              height: 36,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  bleController.isAutoBright.isTrue
                      ? Image.asset("assets/images/light-bulb.png")
                      : Image.asset("assets/images/light-bulb-off.png"),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "자동 밝기 켬",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: bleController.isAutoBright.isTrue
                          ? CarsixColors.white1
                          : CarsixColors.grey9,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: bleController.isAutoBright.isTrue
                    ? null
                    : CarsixColors.grey8,
                gradient: bleController.isAutoBright.isTrue
                    ? LinearGradient(
                        colors: [
                          Color(0xFF9B000C), // #9B000C
                          Color(0xFF4D0006), // #4D0006
                        ],
                        begin: Alignment.centerLeft, // 90deg 방향
                        end: Alignment.centerRight,
                      )
                    : null,
                boxShadow: bleController.isAutoBright.isTrue
                    ? [
                        BoxShadow(
                          color: CarsixColors.primaryRed
                              .withOpacity(0.2), // #E6001240
                          offset: Offset(0, 4), // X, Y 축의 그림자 위치
                          blurRadius: 4, // 흐림 정도
                        ),
                      ]
                    : null,
                borderRadius: BorderRadius.circular(20), // 모서리 둥글게 (선택)
              )),
        ));
  }
}
