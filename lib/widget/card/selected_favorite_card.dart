import 'package:carsix/const/color.dart';
import 'package:carsix/modules/favorite/controllers/favorite_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedFavoriteCard extends StatelessWidget {
  final String title; // 타이틀을 받을 변수
  final String content; // 컨텐츠를 받을 변수

  // 생성자를 통해 title과 content를 받도록 설정
  SelectedFavoriteCard({super.key, required this.title, required this.content});
  final FavoriteController controller = Get.put(FavoriteController());
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: CarsixColors.grey2),
        borderRadius: BorderRadius.all(Radius.circular(5)),
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
                  "즐겨찾기 목록", // 받아온 타이틀을 표시
                  style: TextStyle(
                    color: CarsixColors.grey2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Obx(() => controller.favoriteColors.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          Get.toNamed("/favorite");
                        },
                        icon: Icon(
                          Icons.edit,
                          color: themeController.isDarkMode.value
                              ? Colors.white
                              : CarsixColors.grey1,
                        ),
                      )
                    : Container())
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            // 즐겨찾기 컬러 리스트를 그리드 형태로 표시
            Obx(
              () => controller.favoriteColors.isEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RedBtn(
                              width: 200,
                              color: CarsixColors.red2,
                              onPressed: () {
                                Get.toNamed("/favorite");
                              },
                              title: Text(
                                "컬러를 추가 해 주세요",
                                style: TextStyle(
                                  color: CarsixColors.white1,
                                ),
                              ))
                        ],
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true, // 그리드뷰 크기를 컨테이너에 맞게 조정
                      physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, // 한 행에 두 개씩 배치
                        crossAxisSpacing: 10, // 컬러 박스 사이의 간격
                        mainAxisSpacing: 10, // 행 간의 간격
                        childAspectRatio: 8, // 직사각형 비율 (가로 대비 세로 비율)
                      ),
                      itemCount: controller.favoriteColors.length,
                      itemBuilder: (BuildContext context, int index) {
                        final color = controller.favoriteColors[index];
                        return Container(
                          height: 60, // 컬러 박스의 높이
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(
                              color: themeController.isDarkMode.isTrue
                                  ? Colors.white
                                  : CarsixColors.grey1,
                              width: 2,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            color.hex,
                            style: const TextStyle(fontSize: 16),
                          )),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
