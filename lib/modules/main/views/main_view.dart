import 'package:carsix/const/color.dart';
import 'package:carsix/content/device/device_content.dart';
import 'package:carsix/content/individual/individual_content.dart';
import 'package:carsix/content/led/led_content.dart';
import 'package:carsix/content/mode/mode_content.dart';
import 'package:carsix/content/mypage/mypage_content.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/btn/apply_btn.dart';
import 'package:carsix/widget/chip/bottom_nav_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  final MainController controller = Get.find<MainController>();
  final BLEController bleController = Get.find<BLEController>();
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
      // backgroundColor: Color(0xfff5f5f5),
      body: Obx(() {
        // 각 페이지의 내용이 변경되도록
        switch (controller.currentIndex.value) {
          case 0:
            return ModeContent();
          case 1:
            return LedContent();
          case 2:
            return DeviceContent();
          case 3:
            return IndividualContent();
          case 4:
            return MyPageContent();
          default:
            return DeviceContent();
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ApplyBtn(
        title: "이 설정 적용하기",
        onTap: () {
          if (controller.currentIndex.value == 0) {
            if (bleController.currentTabIndex == 1) {
              bleController.sendActiveMode();
            } else if (bleController.currentTabIndex == 2) {
              bleController.applySingleMode();
            }
          }
        },
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          showUnselectedLabels: true,
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.changeTab(index),
          backgroundColor: themeController.isDarkMode.value
              ? CarsixColors.grey1
              : CarsixColors.white2, // 다크모드 배경색
          selectedItemColor: CarsixColors.white1,

          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              backgroundColor: themeController.isDarkMode.value
                  ? CarsixColors.grey1
                  : CarsixColors.white2,
              icon: BottomNavIcon(
                iconType: BottomNavIconType.home,
                isActive: false,
              ),
              activeIcon: BottomNavIcon(
                iconType: BottomNavIconType.home,
                isActive: true,
              ),
              label: '모드',
            ),
            BottomNavigationBarItem(
              backgroundColor: themeController.isDarkMode.value
                  ? CarsixColors.grey1
                  : CarsixColors.white2,
              icon: BottomNavIcon(
                iconType: BottomNavIconType.led,
                isActive: false,
              ),
              activeIcon: BottomNavIcon(
                iconType: BottomNavIconType.led,
                isActive: true,
              ),
              label: '조명',
            ),
            BottomNavigationBarItem(
              backgroundColor: themeController.isDarkMode.value
                  ? CarsixColors.grey1
                  : CarsixColors.white2,
              icon: BottomNavIcon(
                iconType: BottomNavIconType.car,
                isActive: false,
              ),
              activeIcon: BottomNavIcon(
                iconType: BottomNavIconType.car,
                isActive: true,
              ),
              label: '연결',
            ),
            BottomNavigationBarItem(
              backgroundColor: themeController.isDarkMode.value
                  ? CarsixColors.grey1
                  : CarsixColors.white2,
              icon: BottomNavIcon(
                iconType: BottomNavIconType.color,
                isActive: false,
              ),
              activeIcon: BottomNavIcon(
                iconType: BottomNavIconType.color,
                isActive: true,
              ),
              label: '색상',
            ),
            BottomNavigationBarItem(
              backgroundColor: themeController.isDarkMode.value
                  ? CarsixColors.grey1
                  : CarsixColors.white2,
              icon: BottomNavIcon(
                iconType: BottomNavIconType.settings,
                isActive: false,
              ),
              activeIcon: BottomNavIcon(
                iconType: BottomNavIconType.settings,
                isActive: true,
              ),
              label: '설정',
            ),
          ],
        );
      }),
    );
  }
}
