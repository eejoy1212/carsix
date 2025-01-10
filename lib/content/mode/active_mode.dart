import 'package:carsix/const/color.dart';
import 'package:carsix/const/style.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/widget/bar/default_appbar.dart';
import 'package:carsix/widget/btn/cerymony_btn.dart';
import 'package:carsix/widget/btn/weather_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ActiveModeContent extends StatelessWidget {
  ActiveModeContent({super.key});
  TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: CarsixColors.white1,
  );
  @override
  Widget build(BuildContext context) {
    final BLEController controller = Get.find<BLEController>();
    bool getSelected(String type) {
      bool isSelected =
          controller.activeModeModel.value.nowSelectedCeremony == type;
      return isSelected;
    }

//1.저장하기 누르면 save 후 Get.back()
//2.뒤로가기 누르면 save하지 않고 Get.back()
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: DefaultAppbar(
          title: "액티브 모드 설정",
          onSave: () {
            // 1. 저장할때 isComplete true로
            controller.saveCeremonyMode(context);
          },
          backRoute: 'main',
          // isComplete: controller.isActiveSaveComplete.value,
          // initComplete: () {
          //   // 2. 저장 됐으면, 백버튼 누를때 저장하라는 창 안뜨고, 바로 뒤로가기 되면서 isComplete 초기화(false)
          //   controller.isActiveSaveComplete.value = false;
          //   print("initComplete>>>${controller.isActiveSaveComplete.value}");
          // },
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
                        Obx(() => CerymonyBtn(
                              width:
                                  (MediaQuery.of(context).size.width - 66) / 3,
                              title: "웰컴 1",
                              onTap: () {
                                Get.toNamed("/welcome", parameters: {
                                  "mode": 1.toString(),
                                  "type": "welcome"
                                });
                              },
                              onLongPress: () {
                                final currentModel =
                                    controller.activeModeModel.value;
                                controller.activeModeModel.value = currentModel
                                    .copyWith(nowSelectedCeremony: "welcome_1");
                              },
                              selectedColor:
                                  controller.activeModeModel.value.welcome1,
                              isSelected: getSelected("welcome_1"),
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => CerymonyBtn(
                              width:
                                  (MediaQuery.of(context).size.width - 66) / 3,
                              title: "웰컴 2",
                              selectedColor:
                                  controller.activeModeModel.value.welcome2,
                              isSelected: getSelected("welcome_2"),
                              onTap: () {
                                Get.toNamed("/welcome", parameters: {
                                  "mode": 2.toString(),
                                  "type": "welcome"
                                });
                              },
                              onLongPress: () {
                                final currentModel =
                                    controller.activeModeModel.value;
                                controller.activeModeModel.value = currentModel
                                    .copyWith(nowSelectedCeremony: "welcome_2");
                              },
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => WeatherBtn(
                              width:
                                  (MediaQuery.of(context).size.width - 66) / 3,
                              isSelected: getSelected("weather"),
                              onTap: () {
                                Get.toNamed("/welcome", parameters: {
                                  "mode": 1.toString(),
                                  "type": "weather"
                                });
                              },
                              onLongPress: () {
                                final currentModel =
                                    controller.activeModeModel.value;
                                controller.activeModeModel.value = currentModel
                                    .copyWith(nowSelectedCeremony: "weather");
                              },
                            )),
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
                        Obx(() => CerymonyBtn(
                              width:
                                  (MediaQuery.of(context).size.width - 66) / 3,
                              title: "굿바이 1",
                              selectedColor:
                                  controller.activeModeModel.value.goodbye1,
                              isSelected: getSelected("goodbye_1"),
                              onTap: () {
                                Get.toNamed("/welcome", parameters: {
                                  "mode": 1.toString(),
                                  "type": "goodbye"
                                });
                              },
                              onLongPress: () {
                                final currentModel =
                                    controller.activeModeModel.value;
                                controller.activeModeModel.value = currentModel
                                    .copyWith(nowSelectedCeremony: "goodbye_1");
                              },
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => CerymonyBtn(
                              width:
                                  (MediaQuery.of(context).size.width - 66) / 3,
                              title: "굿바이 2",
                              selectedColor:
                                  controller.activeModeModel.value.goodbye2,
                              isSelected: getSelected("goodbye_2"),
                              onTap: () {
                                Get.toNamed("/welcome", parameters: {
                                  "mode": 2.toString(),
                                  "type": "goodbye"
                                });
                              },
                              onLongPress: () {
                                final currentModel =
                                    controller.activeModeModel.value;
                                controller.activeModeModel.value = currentModel
                                    .copyWith(nowSelectedCeremony: "goodbye_2");
                              },
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => CerymonyBtn(
                              width:
                                  (MediaQuery.of(context).size.width - 66) / 3,
                              title: "굿바이 3",
                              selectedColor:
                                  controller.activeModeModel.value.goodbye3,
                              isSelected: getSelected("goodbye_3"),
                              onTap: () {
                                Get.toNamed("/welcome", parameters: {
                                  "mode": 3.toString(),
                                  "type": "goodbye"
                                });
                              },
                              onLongPress: () {
                                final currentModel =
                                    controller.activeModeModel.value;
                                controller.activeModeModel.value = currentModel
                                    .copyWith(nowSelectedCeremony: "goodbye_3");
                              },
                            )),
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
