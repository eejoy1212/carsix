import 'package:carsix/const/color.dart';
import 'package:carsix/const/style.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/gauge/circular_gauge.dart';
import 'package:carsix/widget/paper/led_status_paper.dart';
import 'package:carsix/widget/slider/carsix_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LedContent extends StatelessWidget {
  LedContent({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final BLEController controller = Get.find<BLEController>();

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
                    width: width - 160,
                  ),
                  // 좌측센터
                  Positioned(
                      top: 70,
                      left: 20,
                      child: Obx(() => LedStatusPaper(
                            color: Rx<Color>(controller
                                    .lightingModel.value.leftCenterColor)
                                .value,
                            onTap: () {
                              Get.toNamed("/led-setting",
                                  parameters: {"type": "좌측 센터"});
                            },
                            title: '좌측 센터',
                            value: controller
                                .lightingModel.value.leftCenterBright
                                .toInt(),
                          ))),
                  // 우측 센터
                  Positioned(
                      top: 70,
                      right: 20,
                      child: Obx(() => LedStatusPaper(
                            color: Rx<Color>(controller
                                    .lightingModel.value.rightCenterColor)
                                .value,
                            onTap: () {
                              Get.toNamed("/led-setting",
                                  parameters: {"type": "우측 센터"});
                            },
                            title: '우측 센터',
                            value: controller
                                .lightingModel.value.rightCenterBright
                                .toInt(),
                          ))),
                  //좌측 1열 운전석
                  Positioned(
                      top: 175,
                      left: 0,
                      child: Obx(() => LedStatusPaper(
                          color: Rx<Color>(controller
                                  .lightingModel.value.leftFirstDriverColor)
                              .value,
                          onTap: () {
                            Get.toNamed("/led-setting",
                                parameters: {"type": "좌측 1열 운전석"});
                          },
                          title: '좌측 1열 운전석',
                          value: controller
                              .lightingModel.value.leftFirstDriverBright
                              .toInt()))),
                  //우측 1열 조수석
                  Positioned(
                      top: 175,
                      right: 0,
                      child: Obx(() => LedStatusPaper(
                          color: Rx<Color>(controller
                                  .lightingModel.value.rightFirstPassengerColor)
                              .value,
                          onTap: () {
                            Get.toNamed("/led-setting",
                                parameters: {"type": "우측 1열 조수석"});
                          },
                          title: '우측 1열 조수석',
                          value: controller
                              .lightingModel.value.rightFirstPassengerBright
                              .toInt()))),
                  //좌측 2열 운전석
                  Positioned(
                      top: 280,
                      left: 0,
                      child: Obx(() => LedStatusPaper(
                          color: Rx<Color>(controller
                                  .lightingModel.value.leftSecondDriverColor)
                              .value,
                          onTap: () {
                            Get.toNamed("/led-setting",
                                parameters: {"type": "좌측 2열 운전석"});
                          },
                          title: '좌측 2열 운전석',
                          value: controller
                              .lightingModel.value.leftSecondDriverBright
                              .toInt()))),
                  //우측 2열 조수석
                  Positioned(
                      top: 280,
                      right: 0,
                      child: Obx(() => LedStatusPaper(
                          color: Rx<Color>(controller.lightingModel.value
                                  .rightSecondPassengerColor)
                              .value,
                          onTap: () {
                            Get.toNamed("/led-setting",
                                parameters: {"type": "우측 2열 조수석"});
                          },
                          title: '우측 2열 조수석',
                          value: controller
                              .lightingModel.value.rightSecondPassengerBright
                              .toInt()))),
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
                    CarsixSlider(
                      value: 10,
                      onChange: (double value) {},
                    )
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
