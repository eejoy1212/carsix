import 'package:carsix/const/color.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/widget/btn/favorite_color_btn.dart';
import 'package:carsix/widget/card/auto_bright_card.dart';
import 'package:carsix/widget/card/selected_favorite_card.dart';
import 'package:flex_color_picker/flex_color_picker.dart'; // flex_color_picker import
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModeContent extends StatelessWidget {
  const ModeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 컨트롤러를 인스턴스화
    final MainController controller = Get.put(MainController());

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
                    SingleChildScrollView(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FavoriteColorBtn(),
                            SelectedFavoriteCard(
                                title: "title", content: "content")
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '뮤직 모드 설정',
                        style: TextStyle(
                          color: CarsixColors.white1,
                          fontSize: 18,
                        ),
                      ),
                    ),
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
