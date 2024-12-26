import 'package:carsix/const/color.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SettingCard extends StatelessWidget {
  final String content; // 컨텐츠를 받을 변수
  final IconData icon;
  final Color iconColor;
  final void Function()? onTap;
  // 생성자를 통해 title과 content를 받도록 설정
  SettingCard({
    super.key,
    required this.content,
    required this.icon,
    this.iconColor = Colors.white,
    this.onTap,
  });
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          SizedBox(
            width: 10,
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
          Spacer(),
          Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 20,
          ),
        ]),
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
      ),
    );
  }
}
