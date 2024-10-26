import 'package:carsix/const/color.dart';
import 'package:carsix/content/tabview/active_tabview.dart';
import 'package:carsix/content/tabview/custom_tabview.dart';
import 'package:carsix/content/tabview/music_tabview.dart';
import 'package:carsix/content/tabview/single_color_tabview.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModeContent extends StatelessWidget {
  ModeContent({super.key});
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: DefaultTabController(
          length: 4, // 탭의 수
          child: Column(
            children: [
              // 어떤 탭인지 타이틀
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  children: [
                    Text(
                      "액티브 모드",
                      style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? CarsixColors.white1
                            : CarsixColors.grey6,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              // 탭바 추가
              TabBar(
                labelColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.primaryRed,
                unselectedLabelColor: CarsixColors.grey2,
                indicatorColor: CarsixColors.primaryRed,
                tabs: const [
                  Tab(text: "액티브 모드"),
                  Tab(text: "단색 모드"),
                  Tab(text: "뮤직 모드"),
                  Tab(text: "커스텀 모드"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // 각 탭에 표시할 위젯
                    ActiveTabView(),
                    // 단색 모드 화면
                    SingleColorTabView(),
                    MusicTabView(),
                    CustomTabView()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
