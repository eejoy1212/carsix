import 'package:carsix/const/color.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicColorBtn extends StatelessWidget {
  MusicColorBtn({super.key});
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(
            color: themeController.isDarkMode.value
                ? CarsixColors.grey4
                : CarsixColors.white2),
        color: themeController.isDarkMode.value
            ? CarsixColors.grey1
            : CarsixColors.white2,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
            spreadRadius: 2, // 그림자가 퍼지는 정도
            blurRadius: 5, // 그림자의 흐림 정도
            offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed("/music-color");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "뮤직 컬러 추가 하기",
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.grey1,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
