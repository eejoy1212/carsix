import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/card/active_card.dart';
import 'package:carsix/widget/slider/carsix_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicTabView extends StatelessWidget {
  MusicTabView({super.key});

  final BLEController bleController = Get.find<BLEController>();
  final themeController = Get.find<ThemeController>();

  final List<String> buttonTitles = [
    "뮤직 모드 1",
    "뮤직 모드 2",
    "뮤직 모드 3",
    "뮤직 모드 4",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              _buildButtonRow(0, 1),
              const SizedBox(height: 20),
              _buildButtonRow(2, 3),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 버튼 행을 만드는 함수
  Widget _buildButtonRow(int index1, int index2) {
    return Row(
      children: [
        Expanded(
          child: _buildActiveCard(index1),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildActiveCard(index2),
        ),
      ],
    );
  }

  /// ActiveCard를 만드는 함수
  Widget _buildActiveCard(int index) {
    return Obx(() => ActiveCard(
          useSetting: true,
          isSelected: bleController.selectedMusicButtonIndex.value == index,
          onApply: () {
            bleController.selectedMusicButtonIndex.value = index;
          },
          title: buttonTitles[index],
          onSetting: () {
            bleController.loadMusicMode(index + 1);
            Get.toNamed('/music-setting',
                parameters: {"mode": index.toString()});
            // 설정 페이지로 이동 (필요 시 구현)
            // Get.toNamed("/active-mode", parameters: {"mode": index.toString()});
          },
          nowApply: bleController.selectedMusicButtonIndex.value == index,
        ));
  }
}
