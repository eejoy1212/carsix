import 'package:carsix/const/color.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DeviceCard extends StatelessWidget {
  final String title; // 타이틀을 받을 변수
  final String content; // 컨텐츠를 받을 변수

  // 생성자를 통해 title과 content를 받도록 설정
  DeviceCard({super.key, required this.title, required this.content});
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeController.isDarkMode.value
            ? CarsixColors.grey1
            : CarsixColors.white2,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
            spreadRadius: 2, // 그림자가 퍼지는 정도
            blurRadius: 5, // 그림자의 흐림 정도
            offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 16, bottom: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title, // 받아온 타이틀을 표시
                  style: TextStyle(
                    color: CarsixColors.grey2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  content, // 받아온 컨텐츠를 표시
                  style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? CarsixColors.white1
                        : CarsixColors.black1,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
