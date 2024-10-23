import 'package:carsix/const/color.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveTabView extends StatelessWidget {
  ActiveTabView({super.key});
  final MainController controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: [
          //속도 설정
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
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
                  "속도 설정",
                  style: TextStyle(
                    color: CarsixColors.grey2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // 주석 아래에 슬라이더 배치
                SliderTheme(
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
                    value: 10, //controller.musicSensitivity.value,
                    min: 0.0,
                    max: 100.0,
                    divisions: 100,
                    label:
                        '10', //controller.musicSensitivity.value.round().toString(),
                    onChanged: (double value) {
                      // controller.musicSensitivity.value = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          // Divider(
          //   color: CarsixColors.grey2,
          //   indent: 20,
          //   endIndent: 20,
          // ),
//웰컴 세리머니 색상
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: CarsixColors.grey1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "웰컴 세리머니 색상",
                      style: TextStyle(
                        color: CarsixColors.grey2,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/welcome');
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Obx(
                  () => Row(
                      children: controller.welcomeColors
                          .map((color) => Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 16,
                                  ),
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
                                ),
                              ))
                          .toList()),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          //굿바이 세리머니 색상
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: CarsixColors.grey1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "굿바이 세리머니 색상",
                      style: TextStyle(
                        color: CarsixColors.grey2,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/welcome');
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Obx(
                  () => Row(
                      children: controller.welcomeColors
                          .map((color) => Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 16,
                                  ),
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
                                ),
                              ))
                          .toList()),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
