import 'package:carsix/const/color.dart';
import 'package:carsix/const/style.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/models/active_mode_model.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/widget/bar/default_appbar.dart';
import 'package:carsix/widget/paper/favorite_color_paper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({super.key});
  final MainController controller = Get.find<MainController>();
  final BLEController bleController = Get.find<BLEController>();
  final String modeString = Get.parameters['mode'] ?? "";
  final String typeString = Get.parameters['type'] ?? "";
  @override
  Widget build(BuildContext context) {
    int getColorStatus() {
      String mode = typeString + "_" + modeString;
      switch (mode) {
        case "welcome_1":
          //즐겨찾기에 선택한 컬러가 없는 경우->선택 색상 저장하기
          if (!bleController.activeModeModel.value.welcome1Favorites
              .contains(bleController.activeModeModel.value.welcome1)) {
            return 0;
          } else {
            return 2;
          }
        case "welcome_2":
          if (!bleController.activeModeModel.value.welcome2Favorites
              .contains(bleController.activeModeModel.value.welcome2)) {
            return 0;
          } else {
            return 2;
          }
        case "goodbye_1":
          if (!bleController.activeModeModel.value.goodbye1Favorites
              .contains(bleController.activeModeModel.value.goodbye1)) {
            return 0;
          } else {
            return 2;
          }

        case "goodbye_2":
          if (!bleController.activeModeModel.value.goodbye2Favorites
              .contains(bleController.activeModeModel.value.goodbye2)) {
            return 0;
          } else {
            return 2;
          }

        case "goodbye_3":
          if (!bleController.activeModeModel.value.goodbye3Favorites
              .contains(bleController.activeModeModel.value.goodbye3)) {
            return 0;
          } else {
            return 2;
          }
        default:
          return 2;
      }
    }

    Color getSelectedColor() {
      String mode = typeString + "_" + modeString;

      switch (mode) {
        case "welcome_1":
          return bleController.activeModeModel.value.welcome1;
        case "welcome_2":
          return bleController.activeModeModel.value.welcome2;
        case "goodbye_1":
          return bleController.activeModeModel.value.goodbye1;
        case "goodbye_2":
          return bleController.activeModeModel.value.goodbye2;
        case "goodbye_3":
          return bleController.activeModeModel.value.goodbye3;
        default:
          return Colors.transparent;
      }
    }

    List<Color> getFavoriteColors() {
      String mode = typeString + "_" + modeString;
      ActiveMode activeMode = bleController.activeModeModel.value;
      switch (mode) {
        case "welcome_1":
          return activeMode.welcome1Favorites;
        case "welcome_2":
          return activeMode.welcome2Favorites;
        case "goodbye_1":
          return activeMode.goodbye1Favorites;
        case "goodbye_2":
          return activeMode.goodbye2Favorites;
        case "goodbye_3":
          return activeMode.goodbye3Favorites;
        default:
          return [];
      }
    }

    void onColorChange(Color color) {
      String mode = typeString + "_" + modeString;

      // 현재 모델 객체를 복사하여 수정
      final currentModel = bleController.activeModeModel.value;

      switch (mode) {
        case "welcome_1":
          bleController.activeModeModel.value =
              currentModel.copyWith(welcome1: color);
          break;
        case "welcome_2":
          bleController.activeModeModel.value =
              currentModel.copyWith(welcome2: color);
          break;
        case "goodbye_1":
          bleController.activeModeModel.value =
              currentModel.copyWith(goodbye1: color);
          break;
        case "goodbye_2":
          bleController.activeModeModel.value =
              currentModel.copyWith(goodbye2: color);
          break;
        case "goodbye_3":
          bleController.activeModeModel.value =
              currentModel.copyWith(goodbye3: color);
          break;
      }
    }

    void selectFavoriteColor(Color color) {
      String mode = typeString + "_" + modeString;
      final currentModel = bleController.activeModeModel.value;

      switch (mode) {
        case "welcome_1":
          bleController.activeModeModel.value =
              currentModel.copyWith(welcome1: color);
          break;

        case "welcome_2":
          bleController.activeModeModel.value =
              currentModel.copyWith(welcome2: color);
          break;

        case "goodbye_1":
          bleController.activeModeModel.value =
              currentModel.copyWith(goodbye1: color);
          break;

        case "goodbye_2":
          bleController.activeModeModel.value =
              currentModel.copyWith(goodbye2: color);
          break;

        case "goodbye_3":
          bleController.activeModeModel.value =
              currentModel.copyWith(goodbye3: color);
          break;

        default:
          print("Invalid mode: $mode");
      }
    }

    return Scaffold(
      appBar: DefaultAppbar(
        title: "${typeString == "welcome" ? "웰컴" : "굿바이"} $modeString",
        onSave: () {
          String mode = typeString == "welcome" ? "웰컴" : "굿바이";
          String activeMode = typeString + "_" + modeString;
          bleController.saveAllActiveMode(
              context, mode + modeString, activeMode);
        },
        backRoute: 'active-mode',
        // isComplete:
        //     bleController.getActiveComplete(typeString + "_" + modeString),
        initComplete: () {
          // 2. 저장 됐으면, 백버튼 누를때 저장하라는 창 안뜨고, 바로 뒤로가기 되면서 isComplete 초기화(false)
          String activeMode = typeString + "_" + modeString;
          if (activeMode == "welcome_1") {
            bleController.isWelcome1SaveComplete.value = false;
          } else if (activeMode == "welcome_2") {
            bleController.isWelcome2SaveComplete.value = false;
          } else if (activeMode == "goodbye_1") {
            bleController.isGoodbye1SaveComplete.value = false;
          } else {
            bleController.isGoodbye2SaveComplete.value = false;
          }
        },
      ),
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
                          "${typeString == "welcome" ? "웰컴" : "굿바이"} $modeString 조명 밝기",
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
                Obx(() => FavoriteColorPaper(
                      selectedColor: getSelectedColor(),
                      onColorChange: (Color color) {
                        onColorChange(color);
                      },
                      onTabColorSelectBtn: () {},
                      colorStatus: Rx(getColorStatus()).value,
                      selectSave: () {
                        bleController
                            .selectActiveSave(typeString + "_" + modeString);
                      },
                      selectRemove: () {
                        bleController
                            .removeActive(typeString + "_" + modeString);
                      },
                      completed: bleController
                          .getActiveComplete(typeString + "_" + modeString),
                      favoriteColors: getFavoriteColors(),
                      onTabFavoriteColor: (Color color) {
                        selectFavoriteColor(color);
                      },
                      useDefaultColors: true,
                    )),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
