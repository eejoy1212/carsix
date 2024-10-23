import 'package:carsix/const/color.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/widget/btn/music_color_btn.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicTabView extends StatelessWidget {
  MusicTabView({super.key});
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            // 라디오 버튼으로 뮤직모드 선택
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: CarsixColors.grey1,
              ),
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
                  Row(
                    children: [
                      Obx(
                        () => Radio<String>(
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return CarsixColors.primaryRed; // 선택된 상태일 때
                            }
                            return CarsixColors.grey2; // 선택되지 않았을 때
                          }),
                          value: "모드1",
                          groupValue: controller.selectedMode.value,
                          onChanged: (value) {
                            controller.selectedMode.value = value!;
                          },
                        ),
                      ),
                      Text("모드1"),
                      Obx(
                        () => Radio<String>(
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return CarsixColors.primaryRed; // 선택된 상태일 때
                            }
                            return CarsixColors.grey2; // 선택되지 않았을 때
                          }),
                          value: "모드2",
                          groupValue: controller.selectedMode.value,
                          onChanged: (value) {
                            controller.selectedMode.value = value!;
                          },
                        ),
                      ),
                      Text("모드2"),
                      Obx(
                        () => Radio<String>(
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return CarsixColors.primaryRed; // 선택된 상태일 때
                            }
                            return CarsixColors.grey2; // 선택되지 않았을 때
                          }),
                          value: "모드3",
                          groupValue: controller.selectedMode.value,
                          onChanged: (value) {
                            controller.selectedMode.value = value!;
                          },
                        ),
                      ),
                      Text("모드3"),
                      Obx(
                        () => Radio<String>(
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return CarsixColors.primaryRed; // 선택된 상태일 때
                            }
                            return CarsixColors.grey2; // 선택되지 않았을 때
                          }),
                          value: "모드4",
                          groupValue: controller.selectedMode.value,
                          onChanged: (value) {
                            controller.selectedMode.value = value!;
                          },
                        ),
                      ),
                      Text("모드4"),
                    ],
                  )
                ],
              ),
            ),
            // 뮤직 감도 조정
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: CarsixColors.grey1,
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
            )
            //컬러 선택
            ,
            //뮤직컬러 선택 페이지 버튼
            MusicColorBtn(),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: CarsixColors.grey1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "뮤직 컬러",
                    style: TextStyle(
                      color: CarsixColors.grey2,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // 즐겨찾기 컬러 리스트를 그리드 형태로 표시
                  Obx(
                    () => controller.musicColors.isEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("컬러를 추가 해 주세요"),
                              ],
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true, // 그리드뷰 크기를 컨테이너에 맞게 조정
                            physics:
                                const NeverScrollableScrollPhysics(), // 스크롤 비활성화
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, // 한 행에 두 개씩 배치
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
          ],
        ),
      ),
    );
  }
}
