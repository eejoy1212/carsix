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
    return Obx(() => Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: CarsixColors.grey2),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 16, bottom: 16),
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
        ));
  }
}
