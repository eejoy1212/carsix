import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:carsix/widget/card/device_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceContent extends StatefulWidget {
  DeviceContent({super.key});

  @override
  _DeviceContentState createState() => _DeviceContentState();
}

class _DeviceContentState extends State<DeviceContent> {
  final themeController = Get.find<ThemeController>();
  final bleController = Get.find<BLEController>();
  final mainController = Get.find<MainController>();

  @override
  void initState() {
    super.initState();
    mainController.loadDeviceInfo(); // 초기 데이터 로드
  }

  Future<void> _refreshDeviceInfo() async {
    await mainController.loadDeviceInfo(); // 데이터 새로고침
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  children: [
                    Text(
                      "디바이스 ",
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
              Column(
                children: [
                  DeviceCard(
                    title: '제조사',
                    content:
                        mainController.manufacturerController.text.isNotEmpty
                            ? mainController.manufacturerController.text
                            : 'N/A',
                  ),
                  DeviceCard(
                    title: '차량',
                    content: mainController.vehicleController.text.isNotEmpty
                        ? mainController.vehicleController.text
                        : 'N/A',
                  ),
                  DeviceCard(
                    title: '차량번호',
                    content:
                        mainController.licensePlateController.text.isNotEmpty
                            ? mainController.licensePlateController.text
                            : 'N/A',
                  ),
                  DeviceCard(
                    title: '시공점',
                    content: mainController
                            .installationPlaceController.text.isNotEmpty
                        ? mainController.installationPlaceController.text
                        : 'N/A',
                  ),
                  DeviceCard(
                    title: '연결제품',
                    content: "연결제품",
                  ),
                  DeviceCard(
                    title: '펌웨어',
                    content: "펌웨어",
                  ),
                  DeviceCard(
                    title: '하드웨어 버전',
                    content: "하드웨어 버전",
                  ),
                ],
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: RedBtn(
                  onPressed: () async {
                    final result = await Get.toNamed('/device-edit');
                    if (result == true) {
                      await _refreshDeviceInfo(); // 데이터 새로고침
                    }
                  },
                  color: CarsixColors.primaryRed,
                  title: Text(
                    "수정 하기",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: CarsixColors.white1,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
