import 'package:carsix/const/color.dart';
import 'package:carsix/content/tabview/music_tabview.dart';
import 'package:carsix/content/tabview/single_color_tabview.dart';
import 'package:flutter/material.dart';

class ModeContent extends StatelessWidget {
  const ModeContent({super.key});

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
                        color: CarsixColors.white1,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              // 페이지에 대한 설명
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "설명을 적어주세요",
                      style: TextStyle(
                        color: CarsixColors.grey2,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // 탭바 추가
              TabBar(
                labelColor: CarsixColors.white1,
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
                    Center(
                      child: Text(
                        '액티브 모드 설정',
                        style: TextStyle(
                          color: CarsixColors.white1,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    // 단색 모드 화면
                    SingleColorTabView(),
                    MusicTabView(),
                    Center(
                      child: Text(
                        '커스텀 모드 설정',
                        style: TextStyle(
                          color: CarsixColors.white1,
                          fontSize: 18,
                        ),
                      ),
                    ),
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
