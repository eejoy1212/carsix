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
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, // 받아온 타이틀을 표시
                style: TextStyle(
                  color: Color(0xFF898989),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Text(
                  content, // 받아온 컨텐츠를 표시
                  style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? CarsixColors.white1
                        : CarsixColors.black1,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1B1B1B), // 시작 색상 (검은색)
                      Color(0x001B1B1B), // 끝 색상 (투명한 검은색)
                    ],
                    begin: Alignment.topCenter, // 그라데이션 시작 위치
                    end: Alignment.bottomCenter, // 그라데이션 끝 위치
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
