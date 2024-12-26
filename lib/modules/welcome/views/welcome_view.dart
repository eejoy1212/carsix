import 'package:carsix/const/color.dart';
import 'package:carsix/const/style.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/widget/bar/default_appbar.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:carsix/widget/paper/favorite_color_paper.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({super.key});
  final MainController controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(title: "웰컴 1"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 28,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          "웰컴 1 조명 밝기",
                          style: CarsixTxtStyle.settingTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          // thumbShape: SliderComponentShape.noOverlay,

                          activeTrackColor: CarsixColors.primaryRed,
                          inactiveTrackColor: CarsixColors.primaryRed
                              .withOpacity(0.2), //CarsixColors.grey2,
                          thumbColor: CarsixColors.white1,
                          overlayColor:
                              CarsixColors.primaryRed.withOpacity(0.2),
                          valueIndicatorColor:
                              CarsixColors.primaryRed, // 라벨의 배경색 변경
                          valueIndicatorTextStyle: TextStyle(
                            color: CarsixColors.white1, // 라벨의 글자색 변경
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
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),

                // 색상 선택기
                FavoriteColorPaper(
                    selectedColor: Colors.redAccent,
                    onColorChange: (Color color) {},
                    onTabColorSelectBtn: () {},
                    colorStatus: 1,
                    selectSave: () {},
                    selectRemove: () {},
                    completed: true,
                    favoriteColors: [],
                    onTabFavoriteColor: (Color color) {}),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
