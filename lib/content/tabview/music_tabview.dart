import 'package:carsix/const/color.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/btn/music_color_btn.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicTabView extends StatelessWidget {
  MusicTabView({super.key});
  final MainController controller = Get.put(MainController());
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            // 칩으로 뮤직모드 선택
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                // color: themeController.isDarkMode.value
                //     ? CarsixColors.grey1
                //     : CarsixColors.white2,
                border: Border.all(color: CarsixColors.grey2),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              // decoration: BoxDecoration(
              //   color: themeController.isDarkMode.value
              //       ? CarsixColors.grey1
              //       : CarsixColors.white2,
              //   borderRadius: BorderRadius.all(Radius.circular(5)),
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
              //       spreadRadius: 2, // 그림자가 퍼지는 정도
              //       blurRadius: 5, // 그림자의 흐림 정도
              //       offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
              //     ),
              //   ],
              // ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "뮤직 모드 선택",
                    style: TextStyle(
                      color: CarsixColors.grey2,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => Wrap(
                        spacing: 8.0, // 칩 간격
                        children: ["모드1", "모드2", "모드3", "모드4"].map((mode) {
                          return ChoiceChip(
                            label: Text(mode),
                            selected: controller.selectedMode.value == mode,
                            onSelected: (selected) {
                              if (selected) {
                                controller.selectedMode.value = mode;
                              }
                            },
                            selectedColor: CarsixColors.primaryRed,
                            backgroundColor:
                                CarsixColors.grey2.withOpacity(0.2),
                            labelStyle: TextStyle(
                              color: controller.selectedMode.value == mode
                                  ? Colors.white
                                  : CarsixColors.grey2,
                            ),
                          );
                        }).toList(),
                      )),
                ],
              ),
            ),
            // 뮤직 감도 조정
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                // color: themeController.isDarkMode.value
                //     ? CarsixColors.grey1
                //     : CarsixColors.white2,
                border: Border.all(color: CarsixColors.grey2),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "뮤직 감도 조정",
                    style: TextStyle(
                      color: CarsixColors.grey2,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // 주석 아래에 슬라이더 배치
                  Obx(
                    () => SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: CarsixColors.primaryRed,
                        inactiveTrackColor: CarsixColors.grey2,
                        thumbColor: CarsixColors.primaryRed,
                        overlayColor: CarsixColors.primaryRed.withOpacity(0.2),
                        valueIndicatorColor: CarsixColors.red2, // 라벨의 배경색 변경
                        valueIndicatorTextStyle: TextStyle(
                          color: Colors.black, // 라벨의 글자색 변경
                          fontSize: 16,
                        ),
                      ),
                      child: Slider(
                        value: controller.musicSensitivity.value,
                        min: 0.0,
                        max: 100.0,
                        divisions: 100,
                        label: controller.musicSensitivity.value
                            .round()
                            .toString(),
                        onChanged: (double value) {
                          controller.musicSensitivity.value = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 뮤직 컬러 선택 페이지 버튼
            // MusicColorBtn(),
            // 뮤직 컬러 리스트
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                // color: themeController.isDarkMode.value
                //     ? CarsixColors.grey1
                //     : CarsixColors.white2,
                border: Border.all(color: CarsixColors.grey2),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "뮤직 컬러",
                        style: TextStyle(
                          color: CarsixColors.grey2,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(() => controller.musicColors.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                Get.toNamed("/music-color");
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
                  const SizedBox(height: 16),
                  Obx(
                    () => controller.musicColors.isEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RedBtn(
                                    width: 200,
                                    color: CarsixColors.red2,
                                    onPressed: () {
                                      Get.toNamed("/music-color");
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
                            physics:
                                const NeverScrollableScrollPhysics(), // 스크롤 비활성화
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, // 한 행에 하나씩 배치
                              crossAxisSpacing: 10, // 컬러 박스 사이의 간격
                              mainAxisSpacing: 10, // 행 간의 간격
                              childAspectRatio: 8, // 직사각형 비율 (가로 대비 세로 비율)
                            ),
                            itemCount: controller.musicColors.length,
                            itemBuilder: (BuildContext context, int index) {
                              final color = controller.musicColors[index];
                              return Container(
                                height: 60, // 컬러 박스의 높이
                                decoration: BoxDecoration(
                                  color: color,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  color.hex,
                                  style: TextStyle(fontSize: 16),
                                )),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: RedBtn(
                    onPressed: () {},
                    title: Text(
                      "저장",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: CarsixColors.white1,
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
