import 'package:carsix/const/color.dart';
import 'package:carsix/content/device/device_content.dart';
import 'package:carsix/content/mode/mode_content.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  final MainController controller = Get.put(MainController());

  final iconList = <IconData>[
    Icons.directions_car,
    Icons.tune,
    Icons.favorite,
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
            return Center(child: Text("Favorites Page"));
          case 3:
            return Center(child: Text("Profile Page"));
          default:
            return Center(child: Text("Home Page"));
        }
      }),
      bottomNavigationBar: Obx(() {
        return AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: controller.currentIndex.value,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          onTap: (index) => controller.changeTab(index),
          // 바텀 네비게이션 바 컬러를 다크모드 배경색으로 설정
          backgroundColor: CarsixColors.grey1, // 다크모드 배경색
          activeColor: CarsixColors.primaryRed,
          inactiveColor: Colors.grey,
          splashColor: CarsixColors.primaryRed,
          iconSize: 24,
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          margin: EdgeInsets.only(left: 8, right: 9, top: 16, bottom: 8),
          child: Image.asset(
            'assets/images/logo_mini_white.png',
          ),
        ),
        backgroundColor: CarsixColors.primaryRed, // FAB 버튼 색상 설정
        shape: CircleBorder(), // FAB가 원형 모양을 유지하도록 설정
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
