import 'package:carsix/const/color.dart';
import 'package:carsix/content/device/device_content.dart';
import 'package:carsix/content/led/led_content.dart';
import 'package:carsix/content/mode/mode_content.dart';
import 'package:carsix/content/mypage/mypage_content.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  final MainController controller = Get.put(MainController());
  final themeController = Get.find<ThemeController>();
  final iconList = <IconData>[
    Icons.directions_car,
    Icons.tune,
    Icons.lightbulb_outline,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // 각 페이지의 내용이 변경되도록
        switch (controller.currentIndex.value) {
          case 0:
            return DeviceContent();
          case 1:
            return ModeContent();
          case 2:
            return LedContent();
          case 3:
            return MyPageContent();
          default:
            return DeviceContent();
        }
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.changeTab(index),
          backgroundColor: themeController.isDarkMode.value
              ? CarsixColors.grey1
              : CarsixColors.white2, // 다크모드 배경색
          selectedItemColor: CarsixColors.primaryRed,

          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              backgroundColor: themeController.isDarkMode.value
                  ? CarsixColors.grey1
                  : CarsixColors.white2,
              icon: Icon(Icons.directions_car),
              label: 'DEVICE',
            ),
            BottomNavigationBarItem(
              backgroundColor: themeController.isDarkMode.value
                  ? CarsixColors.grey1
                  : CarsixColors.white2,
              icon: Icon(Icons.tune),
              label: 'MODE',
            ),
            BottomNavigationBarItem(
              backgroundColor: themeController.isDarkMode.value
                  ? CarsixColors.grey1
                  : CarsixColors.white2,
              icon: Icon(Icons.lightbulb_outline),
              label: 'LED',
            ),
            BottomNavigationBarItem(
              backgroundColor: themeController.isDarkMode.value
                  ? CarsixColors.grey1
                  : CarsixColors.white2,
              icon: Icon(Icons.person),
              label: 'MYPAGE',
            ),
          ],
        );
      }),
    );
  }
}
