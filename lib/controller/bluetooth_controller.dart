import 'dart:convert';

import 'package:carsix/const/color.dart';
import 'package:carsix/const/databas_helper.dart';
import 'package:carsix/models/active_mode_model.dart';
import 'package:carsix/models/custom_mode_model.dart';
import 'package:carsix/models/lighting_model.dart';
import 'package:carsix/models/music_mode_model.dart';
import 'package:carsix/models/single_mode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class BLEController extends GetxController {
  final Dio _dio = Dio();
  //처음 시작 시 적용 모드 가져오기
  RxBool isActiveSaveComplete = RxBool(false);
  final RxString manufacturerText = ''.obs;
  final manufacturerController =
      Rx<TextEditingController>(TextEditingController());
  final RxString vehicleText = ''.obs;
  final vehicleController = Rx<TextEditingController>(TextEditingController());

  final RxString licenseText = ''.obs;
  final licenseController = Rx<TextEditingController>(TextEditingController());

  final RxString installationPlaceText = ''.obs;
  final installationPlaceController =
      Rx<TextEditingController>(TextEditingController());

  // final installationPlaceController = TextEditingController();
  //조명 화면 모델
  Rx<LightingModel> lightingModel = Rx(LightingModel(
    leftCenterColor: Colors.black,
    leftCenterBright: 0.0,
    rightCenterColor: Colors.black,
    rightCenterBright: 0.0,
    leftFirstDriverColor: Colors.black,
    leftFirstDriverBright: 0.0,
    rightFirstPassengerColor: Colors.black,
    rightFirstPassengerBright: 0.0,
    leftSecondDriverColor: Colors.black,
    leftSecondDriverBright: 0.0,
    rightSecondPassengerColor: Colors.black,
    rightSecondPassengerBright: 0.0,
    leftCenterFavorites: [],
    rightCenterFavorites: [],
    leftFirstDriverFavorites: [],
    rightFirstPassengerFavorites: [],
    leftSecondDriverFavorites: [],
    rightSecondPassengerFavorites: [],
  ));
  RxBool isLightingSaveComplete = RxBool(false);
  //0은 아무 모드도 적용안된거
  RxInt currentApplyMode = 0.obs;
  //커스텀 모드 설정
  List<Rx<CustomMode>> customModeModels = List.generate(
      3,
      (int idx) => Rx<CustomMode>(CustomMode(
            apply: false,
            selectedBgCustomColor: Colors.transparent,
            customBgColors: [],
            selectedSel1CustomColor: Colors.transparent,
            customSel1Colors: [],
            selectedSel2CustomColor: Colors.transparent,
            customSel2Colors: [],
            bgBright: 0.0,
            bgVelocity: 0.0,
            sel1Bright: 0.0,
            sel1Velocity: 0.0,
            sel2Bright: 0.0,
            sel2Velocity: 0.0,
          )));
  RxString nowApplyCustomMode = "".obs;
  Rx<Color> selectedBgCustomColor = Colors.transparent.obs;
  RxList<Color> customBgColors = <Color>[].obs;
  Rx<Color> selectedSel1CustomColor = Colors.transparent.obs;
  RxList<Color> customSel1Colors = <Color>[].obs;
  Rx<Color> selectedSel2CustomColor = Colors.transparent.obs;
  RxList<Color> customSel2Colors = <Color>[].obs;
  RxBool isCustomSaveComplete = RxBool(false);
  RxInt selectedCustomButtonIndex = (-1).obs; //뮤직모드 적용할지 안할지 적용하기 버튼 누르는거
  RxDouble customBright = 0.0.obs;
  RxDouble customVelocity = 0.0.obs;
  //커스텀 모드 설정
  //뮤직 모드 설정
  RxDouble musicBright = 0.0.obs;
  List<Rx<MusicMode>> musicModeModel = List<Rx<MusicMode>>.generate(
      4,
      (int idx) => Rx<MusicMode>(MusicMode(
            selectedMusicColor: Colors.transparent,
            musicColors: [],
            musicBright: 0.0,
            apply: false,
          )));
  Rx<Color> selectedMusicColor = Colors.transparent.obs;
  RxList<Color> musicColors = <Color>[].obs;
  RxBool isMusicSaveComplete = RxBool(false);
  RxInt selectedMusicButtonIndex = (-1).obs; //뮤직모드 적용할지 안할지 적용하기 버튼 누르는거
  RxDouble musicSensitivity = 0.0.obs;
  //뮤직 모드 설정
  FlutterBlue flutterBlue = FlutterBlue.instance;
  final Rx<ScrollController> scrollController = ScrollController().obs;
  var isConnected = false.obs;
  var isScanning = false.obs;
  BluetoothDevice? connectedDevice;
  String deviceName = "CAR-SIX LED Controller";
  RxInt currentTabIndex = 1.obs;
  // 속도 설정 변수
  RxDouble speedValue = 10.0.obs;
  BluetoothCharacteristic? characteristic; // 데이터 전송을 위한 BLE 특성
  //액티브 모드 설정
  RxList<Color> singleColors = <Color>[].obs;
  Rx<Color> selectedColor = Colors.transparent.obs;
  Rx<Color> toApplySingleColor = Colors.transparent.obs;
  Rx<bool> isApplySingleColor = true.obs;
  //액티브 모드 설정
  //커스텀 모드 변수
  // Rx<Color> selectedCustomColor = CarsixColors.primaryRed.obs;
  Rx<Color> customBgColor = CarsixColors.primaryRed.obs;
  RxList<Color> customBlockColors = RxList.empty();
  RxBool isCustomBg = RxBool(true);
  RxDouble brightValue = RxDouble(25);
  RxBool isAutoBright = RxBool(true);
  RxInt selectedButtonIndex = (-1).obs;
  RxBool isSelectLoading = RxBool(false);
  RxBool isSingleSaveComplete = RxBool(false);
  RxBool isSliding = false.obs;
  //설정 화면에서 버전 다섯번 터치 했는지 알기 위한 변수
  RxInt touchVersionCount = 0.obs;
  //액티브 모드 설정-세팅화면
//디비에 저장돼있는거 모델
  Rx<ActiveMode> activeModeModel = Rx<ActiveMode>(
    ActiveMode(
      welcome1: Colors.transparent,
      welcome1Favorites: [],
      welcome2: Colors.transparent,
      welcome2Favorites: [],
      weather: '',
      goodbye1: Colors.transparent,
      goodbye1Favorites: [],
      goodbye2: Colors.transparent,
      goodbye2Favorites: [],
      goodbye3: Colors.transparent,
      goodbye3Favorites: [],
      nowSelectedCeremony: '',
    ),
  );
  RxBool isWelcome1SaveComplete = RxBool(false);
  RxBool isWelcome2SaveComplete = RxBool(false);
  RxBool isGoodbye1SaveComplete = RxBool(false);
  RxBool isGoodbye2SaveComplete = RxBool(false);
  RxBool isGoodbye3SaveComplete = RxBool(false);
  //단색 모드 모델
  Rx<SingleMode> singleModeModel = Rx<SingleMode>(
    SingleMode(
      selectedColor: Colors.transparent,
      favoriteColors: [],
    ),
  );

  //단색 모드 모델
  //액티브 모드 설정
  bool getActiveComplete(String mode) {
    if (mode == "welcome_1") {
      return isWelcome1SaveComplete.value;
    } else if (mode == "welcome_2") {
      return isWelcome2SaveComplete.value;
    } else if (mode == "goodbye_1") {
      return isGoodbye1SaveComplete.value;
    } else if (mode == "goodbye_2") {
      return isGoodbye2SaveComplete.value;
    } else {
      return false;
    }
  }

  void updateCustomModeApply(int index, bool applyValue) {
    final currentModel = customModeModels[index].value;

    // 기존 모델 객체를 copyWith로 수정
    final updatedModel = currentModel.copyWith(apply: applyValue);

    // 수정된 모델을 다시 할당
    customModeModels[index].value = updatedModel;
  }

  //뮤직모드 모델 apply 수정
  void updateMusicModeApply(int index, bool applyValue) {
    final currentModel = musicModeModel[index].value;

    // 기존 모델 객체를 copyWith로 수정
    final updatedModel = currentModel.copyWith(apply: applyValue);

    // 수정된 모델을 다시 할당
    musicModeModel[index].value = updatedModel;
  }

//뮤직모드 모델

  void updateMusicModeBright(int index, double brightValue) {
    final currentModel = musicModeModel[index].value;

    // 기존 모델 객체를 copyWith로 수정
    final updatedModel = currentModel.copyWith(musicBright: brightValue);

    // 수정된 모델을 다시 할당
    musicModeModel[index].value = updatedModel;
  }

  // 웰컴 세레모니 색상 선택 프로토콜 함수
  Future<void> sendWelcomeCeremonyColor(int subCommand) async {
    // subCommand 유효성 검사 (0x00 ~ 0x03 범위)
    if (subCommand < 0x00 || subCommand > 0x03) {
      print("유효하지 않은 Sub Command입니다: $subCommand");
      return;
    }

    // 프로토콜 명령어 생성
    List<int> command = [
      0xEA, // Header 1
      0xBF, // Header 2
      0xCC, // Command (Welcome Ceremony)
      subCommand, // Sub Command (0x00 ~ 0x03)
      0x00, // Data1
      0x00, // Data2
      0x00, // Data3
      0x00, // Data4
      0x00, // Data5
      0x00, // Data6
      0x00, // Data7
      0x00, // Data8
      0x00, // Data9
      0xEB, // End
    ];

    // BLE 명령 전송
    if (characteristic != null && isConnected.value) {
      try {
        await characteristic!.write(command, withoutResponse: false);
        print("세리머니 명령 전송 성공: $command");
      } catch (e) {
        print("세리머니 명령 전송 실패: $e");
      }
    } else {
      print("(세리머니)BLE 연결이 설정되지 않았습니다.");
    }
  }

  Future<void> initSingleMode() async {
    final singleModeData = await DatabaseHelper().getSingleColor();
    if (singleModeData != null) {
      singleModeModel.value = SingleMode.fromJson(singleModeData);
    } else {
      singleModeModel.value = SingleMode(
        selectedColor: Colors.transparent,
        favoriteColors: [],
      );
    }
  }

//액티브 모드 설정 함수
  Future<void> initActiveModeSetting() async {
    final activeModeData = await DatabaseHelper().getActiveMode();

    if (activeModeData != null) {
      // 데이터베이스에서 가져온 값을 ActiveMode 모델로 초기화
      activeModeModel.value = ActiveMode.fromJson(activeModeData);
    } else {
      // 데이터가 없을 경우 기본값으로 초기화
      activeModeModel.value = ActiveMode(
        welcome1: Colors.transparent,
        welcome1Favorites: [],
        welcome2: Colors.transparent,
        welcome2Favorites: [],
        weather: '',
        goodbye1: Colors.transparent,
        goodbye1Favorites: [],
        goodbye2: Colors.transparent,
        goodbye2Favorites: [],
        goodbye3: Colors.transparent,
        goodbye3Favorites: [],
        nowSelectedCeremony: 'welcome_1',
      );
    }

    // 로드된 모델 값을 확인하는 디버그 출력
    print('ActiveMode initialized00: ${activeModeData}');
    print('ActiveMode initialized11: ${activeModeModel.value?.toJson()}');
  }

  // Future<void> initActiveModeSetting() async {
  //   final activeMode = await DatabaseHelper().getActiveMode();
  //   print('>>>>>>>>>>> Active Mode: $activeMode');

  //   if (activeMode != null) {
  //     // welcome1 색상 및 즐겨찾기 설정
  //     selectedWelcome1Color.value = Color(int.tryParse(activeMode['welcome1']
  //             .replaceAll('Color(', '')
  //             .replaceAll(')', '')) ??
  //         0x00000000);
  //     welcome1Favorites.value =
  //         parseColorListForActiveMode(activeMode['welcome1Favorites']);

  //     // welcome2 색상 및 즐겨찾기 설정
  //     selectedWelcome2Color.value = Color(int.tryParse(activeMode['welcome2']
  //             .replaceAll('Color(', '')
  //             .replaceAll(')', '')) ??
  //         0x00000000);
  //     welcome2Favorites.value =
  //         parseColorListForActiveMode(activeMode['welcome2Favorites']);

  //     // weather 설정
  //     selectedWeather.value = activeMode['weather'] ?? '';

  //     // goodbye1 색상 및 즐겨찾기 설정
  //     selectedGoodbye1Color.value = Color(int.tryParse(activeMode['goodbye1']
  //             .replaceAll('Color(', '')
  //             .replaceAll(')', '')) ??
  //         0x00000000);
  //     goodbye1Favorites.value =
  //         parseColorListForActiveMode(activeMode['goodbye1Favorites']);

  //     // goodbye2 색상 및 즐겨찾기 설정
  //     selectedGoodbye2Color.value = Color(int.tryParse(activeMode['goodbye2']
  //             .replaceAll('Color(', '')
  //             .replaceAll(')', '')) ??
  //         0x00000000);
  //     goodbye2Favorites.value =
  //         parseColorListForActiveMode(activeMode['goodbye2Favorites']);

  //     // goodbye3 색상 및 즐겨찾기 설정
  //     selectedGoodbye3Color.value = Color(int.tryParse(activeMode['goodbye3']
  //             .replaceAll('Color(', '')
  //             .replaceAll(')', '')) ??
  //         0x00000000);
  //     goodbye3Favorites.value =
  //         parseColorListForActiveMode(activeMode['goodbye3Favorites']);
  //   }
  // }

  List<Color> parseColorListForActiveMode(dynamic jsonData) {
    if (jsonData == null) return [];
    if (jsonData is String) {
      // JSON 문자열을 파싱z
      final List<dynamic> colorValues = jsonDecode(jsonData);
      return colorValues.map((value) => Color(value)).toList();
    } else if (jsonData is List<dynamic>) {
      // 이미 List<dynamic> 형식으로 들어온 경우
      return jsonData
          .map((value) => Color(int.tryParse(
                  value.replaceAll('Color(', '').replaceAll(')', '')) ??
              0x00000000))
          .toList();
    } else {
      throw TypeError();
    }
  }

  void selectActiveSave(String mode) {
    // 현재 모델 가져오기
    final currentModel = activeModeModel.value;

    switch (mode) {
      case "welcome_1":
        if (currentModel.welcome1Favorites.contains(currentModel.welcome1)) {
          return;
        } else {
          isWelcome1SaveComplete.value = true;
          activeModeModel.value = currentModel.copyWith(
            welcome1Favorites: [
              ...currentModel.welcome1Favorites,
              currentModel.welcome1
            ],
          );
        }
        break;

      case "welcome_2":
        if (currentModel.welcome2Favorites.contains(currentModel.welcome2)) {
          return;
        } else {
          isWelcome2SaveComplete.value = true;
          activeModeModel.value = currentModel.copyWith(
            welcome2Favorites: [
              ...currentModel.welcome2Favorites,
              currentModel.welcome2
            ],
          );
        }
        break;

      case "goodbye_1":
        if (currentModel.goodbye1Favorites.contains(currentModel.goodbye1)) {
          return;
        } else {
          isGoodbye1SaveComplete.value = true;
          activeModeModel.value = currentModel.copyWith(
            goodbye1Favorites: [
              ...currentModel.goodbye1Favorites,
              currentModel.goodbye1
            ],
          );
        }
        break;

      case "goodbye_2":
        if (currentModel.goodbye2Favorites.contains(currentModel.goodbye2)) {
          return;
        } else {
          isGoodbye2SaveComplete.value = true;
          activeModeModel.value = currentModel.copyWith(
            goodbye2Favorites: [
              ...currentModel.goodbye2Favorites,
              currentModel.goodbye2
            ],
          );
        }
        break;

      case "goodbye_3":
        if (currentModel.goodbye3Favorites.contains(currentModel.goodbye3)) {
          return;
        } else {
          isGoodbye3SaveComplete.value = true;
          activeModeModel.value = currentModel.copyWith(
            goodbye3Favorites: [
              ...currentModel.goodbye3Favorites,
              currentModel.goodbye3
            ],
          );
        }
        break;

      default:
        return;
    }
  }

  Future<void> saveCeremonyMode(
    BuildContext context,
  ) async {
    try {
      String ceremony = activeModeModel.value.nowSelectedCeremony;
      // 모델에서 값 가져오기
      final activeMode = activeModeModel.value;

      await DatabaseHelper().saveActiveMode(
        welcome1: activeMode.welcome1.value.toString(),
        welcome1Favorites: activeMode.welcome1Favorites
            .map((color) => color.value.toString())
            .toList(),
        welcome2: activeMode.welcome2.value.toString(),
        welcome2Favorites: activeMode.welcome2Favorites
            .map((color) => color.value.toString())
            .toList(),
        weather: activeMode.weather,
        goodbye1: activeMode.goodbye1.value.toString(),
        goodbye1Favorites: activeMode.goodbye1Favorites
            .map((color) => color.value.toString())
            .toList(),
        goodbye2: activeMode.goodbye2.value.toString(),
        goodbye2Favorites: activeMode.goodbye2Favorites
            .map((color) => color.value.toString())
            .toList(),
        goodbye3: activeMode.goodbye3.value.toString(),
        goodbye3Favorites: activeMode.goodbye3Favorites
            .map((color) => color.value.toString())
            .toList(),
        nowSelectedCeremony: ceremony,
      );

      // Get.back();
      String newMode = ceremony;
      switch (ceremony) {
        case "welcome_1":
          newMode = "웰컴 1";
          break;
        case "welcome_2":
          newMode = "웰컴 2";
          break;
        case "goodbye_1":
          newMode = "굿바이 1";
          break;
        case "goodbye_2":
          newMode = "굿바이 2";
          break;
        case "goodbye_3":
          newMode = "굿바이 3";
        case "wearther":
          newMode = "날씨";
          break;
      }

      if (ceremony.contains("welcome")) {
        if (ceremony.contains("1")) {
          sendWelcomeCeremonyColor(0x01);
        } else {
          sendWelcomeCeremonyColor(0x02);
        }
      }

      isActiveSaveComplete.value = true;
      print("saveComplete>>>${isActiveSaveComplete.value}");
      Get.back();
      Get.snackbar(
        "",
        "$newMode 로 변경되었습니다.", // 메시지
        titleText: Text(
          "$newMode 로 변경되었습니다.",
          style: TextStyle(color: CarsixColors.white1, fontSize: 18),
        ),
        messageText: Text(
          "$newMode 로 변경되었습니다.",
          style: TextStyle(color: CarsixColors.white1, fontSize: 16),
        ),
        snackPosition: SnackPosition.BOTTOM, // Snackbar 위치
        maxWidth: MediaQuery.of(context).size.width - 20,
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        duration: Duration(seconds: 1),
      );
    } catch (e) {
      print("Error in saveAllActiveMode: $e");
      Get.snackbar(
        "Error",
        "저장에 실패했습니다: $e",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeActive(String mode) {
    // 현재 모델 가져오기
    final currentModel = activeModeModel.value;

    switch (mode) {
      case "welcome_1":
        if (!currentModel.welcome1Favorites.contains(currentModel.welcome1)) {
          return;
        } else {
          isWelcome1SaveComplete.value = false; // 제거 상태로 변경
          activeModeModel.value = currentModel.copyWith(
            welcome1Favorites: currentModel.welcome1Favorites
                .where((item) => item != currentModel.welcome1)
                .toList(),
          );
        }
        break;

      case "welcome_2":
        if (!currentModel.welcome2Favorites.contains(currentModel.welcome2)) {
          return;
        } else {
          isWelcome2SaveComplete.value = false;
          activeModeModel.value = currentModel.copyWith(
            welcome2Favorites: currentModel.welcome2Favorites
                .where((item) => item != currentModel.welcome2)
                .toList(),
          );
        }
        break;

      case "goodbye_1":
        if (!currentModel.goodbye1Favorites.contains(currentModel.goodbye1)) {
          return;
        } else {
          isGoodbye1SaveComplete.value = false;
          activeModeModel.value = currentModel.copyWith(
            goodbye1Favorites: currentModel.goodbye1Favorites
                .where((item) => item != currentModel.goodbye1)
                .toList(),
          );
        }
        break;

      case "goodbye_2":
        if (!currentModel.goodbye2Favorites.contains(currentModel.goodbye2)) {
          return;
        } else {
          isGoodbye2SaveComplete.value = false;
          activeModeModel.value = currentModel.copyWith(
            goodbye2Favorites: currentModel.goodbye2Favorites
                .where((item) => item != currentModel.goodbye2)
                .toList(),
          );
        }
        break;

      case "goodbye_3":
        if (!currentModel.goodbye3Favorites.contains(currentModel.goodbye3)) {
          return;
        } else {
          isGoodbye3SaveComplete.value = false;
          activeModeModel.value = currentModel.copyWith(
            goodbye3Favorites: currentModel.goodbye3Favorites
                .where((item) => item != currentModel.goodbye3)
                .toList(),
          );
        }
        break;

      default:
        return;
    }
  }

  Future<void> saveAllActiveMode(
      BuildContext context, String mode, String activeModeString) async {
    try {
      // 모델에서 값 가져오기
      final activeMode = activeModeModel.value;

      await DatabaseHelper().saveActiveMode(
        welcome1: activeMode.welcome1.value.toString(),
        welcome1Favorites: activeMode.welcome1Favorites
            .map((color) => color.value.toString())
            .toList(),
        welcome2: activeMode.welcome2.value.toString(),
        welcome2Favorites: activeMode.welcome2Favorites
            .map((color) => color.value.toString())
            .toList(),
        weather: activeMode.weather,
        goodbye1: activeMode.goodbye1.value.toString(),
        goodbye1Favorites: activeMode.goodbye1Favorites
            .map((color) => color.value.toString())
            .toList(),
        goodbye2: activeMode.goodbye2.value.toString(),
        goodbye2Favorites: activeMode.goodbye2Favorites
            .map((color) => color.value.toString())
            .toList(),
        goodbye3: activeMode.goodbye3.value.toString(),
        goodbye3Favorites: activeMode.goodbye3Favorites
            .map((color) => color.value.toString())
            .toList(),
        nowSelectedCeremony: activeMode.nowSelectedCeremony,
      );
      print("activeMode string>>>$activeModeString");
      if (activeModeString == "welcome_1") {
        isWelcome1SaveComplete.value = true;
      } else if (activeModeString == "welcome_2") {
        isWelcome2SaveComplete.value = true;
      } else if (activeModeString == "goodbye_1") {
        isGoodbye1SaveComplete.value = true;
      } else {
        isGoodbye2SaveComplete.value = true;
      }
      Get.back();
      Get.snackbar(
        "",
        "$mode 저장", // 메시지
        titleText: Text(
          "$mode 저장",
          style: TextStyle(color: CarsixColors.white1, fontSize: 18),
        ),
        messageText: Text(
          "$mode 저장",
          style: TextStyle(color: CarsixColors.white1, fontSize: 16),
        ),
        snackPosition: SnackPosition.BOTTOM, // Snackbar 위치
        maxWidth: MediaQuery.of(context).size.width - 20,
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        duration: Duration(seconds: 1),
      );
    } catch (e) {
      print("Error in saveAllActiveMode: $e");
      Get.snackbar(
        "Error",
        "저장에 실패했습니다: $e",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

//액티브 모드 설정 함수
  //밝기 조절하는 다이얼
  void changeBrightness({
    required List<int> brightnessValues,
  }) async {
    // 밝기 값 유효성 검사 (0~250 범위, 총 7개의 데이터)
    if (brightnessValues.length != 7) {
      print("밝기 값은 정확히 7개의 값을 가져야 합니다.");
      return;
    }

    if (brightnessValues.any((value) => value < 0 || value > 250)) {
      print("밝기 값은 0부터 250 사이여야 합니다: $brightnessValues");
      return;
    }

    // 밝기 설정 명령어 생성
    List<int> command = [
      0xEA, // Header 1
      0xBF, // Header 2
      0xC3, // CMD (밝기 설정)
      0x00, // Sub Command
      ...brightnessValues, // Data1 ~ Data7: 각 Strip의 밝기 값
      0x00, // Data8 (0으로 고정)
      0x00, // Data9 (0으로 고정)
      0xEB, // End
    ];

    // BLE 명령어 전송
    if (characteristic != null && isConnected.value) {
      try {
        await characteristic!.write(command, withoutResponse: false);
        print("밝기 설정 명령 전송 성공: $command");
      } catch (e) {
        print("밝기 설정 명령 전송 실패: $e");
      }
    } else {
      print("BLE 연결이 설정되지 않았습니다.");
    }
  }

  //밝기 조절하는 다이얼
  //로컬 디비
  final DatabaseHelper _dbHelper = DatabaseHelper();
  // Future<void> initMusicSetting() async {
  //   // selectedMusicColor.value = Colors.transparent;
  //   // musicColors.value = <Color>[];
  //   final DatabaseHelper _dbHelper = DatabaseHelper();
  //   final musicModes = await _dbHelper.getMusicModes();
  //   print("musicmodels>>>>>>>>>>>>>>>>>>>>>>>>>$musicModes");
  //   musicModeModel = musicModes;
  //   isMusicSaveComplete.value = false;
  // }
  Future<bool> saveCustomMode() async {
    try {
      final DatabaseHelper _dbHelper = DatabaseHelper();
      await _dbHelper.saveCustomModes(customModeModels);

      isCustomSaveComplete.value = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveMusicMode() async {
    try {
      final DatabaseHelper _dbHelper = DatabaseHelper();
      await _dbHelper.saveMusicModes(musicModeModel);

      isMusicSaveComplete.value = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveLighting() async {
    try {
      final DatabaseHelper _dbHelper = DatabaseHelper();
      await _dbHelper.saveLightingModel(lightingModel);

      // isLightingSaveComplete.value = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  // 데이터 불러오기
  Future<void> loadMusicMode(int mode) async {
    // final String modeKey = "music$mode";
    // final data = await _dbHelper.getMusicMode(modeKey);

    // if (data != null) {
    //   // favorite 컬러 로드
    //   final List<dynamic> favoriteList = jsonDecode(data['favorite']);
    //   musicColors.value = favoriteList.map((color) => Color(color)).toList();

    //   // now 컬러 로드
    //   selectedMusicColor.value = Color(data['now']);
    //   print('불러오기 완료: mode=$modeKey');
    // }
  } //로컬 디비
  String _mapWeatherToKorean(String condition) {
    // WeatherAPI의 상태를 맑음/흐림/비/눈으로 변환
    if (condition.contains('Clear') || condition.contains('Sunny')) {
      return '맑음';
    } else if (condition.contains('Cloudy') || condition.contains('Overcast')) {
      return '흐림';
    } else if (condition.contains('Rain') || condition.contains('Drizzle')) {
      return '비';
    } else if (condition.contains('Snow') || condition.contains('Sleet')) {
      return '눈';
    } else {
      return '알 수 없음';
    }
  }

  Future<String> fetchWeather(BuildContext context) async {
    try {
      //위치 권한 확인
      bool serviceEnabled;
      LocationPermission permission;

      // 위치 서비스 활성화 여부 확인
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('위치 서비스가 비활성화되어 있습니다.');
      }

      // 위치 권한 상태 확인
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('위치 권한이 거부되었습니다.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 활성화하세요.');
      }

      // 위치 권한 요청 및 현재 위치 가져오기
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("position>>>$position");
      String location =
          "${position.latitude},${position.longitude}"; // 위도, 경도 설정

      String apiKey = dotenv.env['WEATHER_API_KEY'] ?? "";
      final url =
          'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location';

      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        final condition = data['current']['condition']['text']; // 날씨 상태

        String weather = _mapWeatherToKorean(condition);
        print("현재 날씨>>>$weather");
        Get.snackbar(
          "",
          ""
              "현재 날씨 $weather", // 메시지
          titleText: Text(
            "현재 날씨 $weather",
            style: TextStyle(color: CarsixColors.white1, fontSize: 18),
          ),
          messageText: Text(
            "현재 날씨 $weather",
            style: TextStyle(color: CarsixColors.white1, fontSize: 16),
          ),
          // backgroundColor: Colors.black, // Snackbar 배경색
          snackPosition: SnackPosition.BOTTOM, // Snackbar 위치
          maxWidth: MediaQuery.of(context).size.width - 20,
          margin: EdgeInsets.only(
            bottom: 20,
          ),
          duration: Duration(seconds: 1),
        );
        return weather;
      } else {
        return '날씨 정보를 가져오지 못했습니다.';
      }
    } catch (e) {
      return '에러가 발생했습니다: $e';
    }
  }
  // Future<String> fetchWeather() async {
  //   // 위치를 내부에서 처리 (예: 기본값 설정)
  //   String location = "Busan"; // 기본 위치 (서울)

  //   // 환경 변수에서 API 키 가져오기
  //   String apiKey = dotenv.env['WEATHER_API_KEY'] ?? "";

  //   final url =
  //       'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location';

  //   try {
  //     final response = await _dio.get(url);

  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       final condition = data['current']['condition']['text']; // 날씨 상태
  //       return _mapWeatherToKorean(condition);
  //     } else {
  //       return '날씨 정보를 가져오지 못했습니다.';
  //     }
  //   } catch (e) {
  //     return '에러가 발생했습니다: $e';
  //   }
  // }

//커스텀모드 컬러 세팅
  void initCustomSetting() {
    selectedBgCustomColor.value = Colors.transparent;
    customBgColors.value = <Color>[];
    selectedSel1CustomColor.value = Colors.transparent;
    customSel1Colors.value = <Color>[];
    selectedSel2CustomColor.value = Colors.transparent;
    customSel2Colors.value = <Color>[];
    isCustomSaveComplete.value = false;
  }

  // void saveCustomMode(
  //   int mode,
  //   String type,
  // ) async {
  //   String modeKey = 'custom$mode';
  //   final dbHelper = DatabaseHelper();

  //   // 기존 데이터 조회
  //   final existingData = await dbHelper.getCustomMode(modeKey);

  //   // 기존 값 설정 (기본값도 포함)
  //   String existingBgFavorite = existingData?['bgFavorite'] ?? '';
  //   int existingBgNow = existingData?['bgNow'] ?? 0;

  //   String existingSel1Favorite = existingData?['sel1Favorite'] ?? '';
  //   int existingSel1Now = existingData?['sel1Now'] ?? 0;

  //   String existingSel2Favorite = existingData?['sel2Favorite'] ?? '';
  //   int existingSel2Now = existingData?['sel2Now'] ?? 0;

  //   // 새로운 favorite 색상 리스트 JSON 형태로 변환
  //   final String favoriteBgJson = jsonEncode(
  //     customBgColors.map((color) => color.value).toList(),
  //   );
  //   final int nowBgColor = selectedBgCustomColor.value.value;

  //   final String favoriteSel1Json = jsonEncode(
  //     customSel1Colors.map((color) => color.value).toList(),
  //   );
  //   final int nowSel1Color = selectedSel1CustomColor.value.value;

  //   final String favoriteSel2Json = jsonEncode(
  //     customSel2Colors.map((color) => color.value).toList(),
  //   );
  //   final int nowSel2Color = selectedSel2CustomColor.value.value;

  //   // type에 따라 새로운 데이터로 업데이트, 나머지는 기존 값 유지
  //   switch (type) {
  //     case 'bg':
  //       existingBgFavorite = favoriteBgJson;
  //       existingBgNow = nowBgColor;
  //       break;
  //     case 'sel1':
  //       existingSel1Favorite = favoriteSel1Json;
  //       existingSel1Now = nowSel1Color;
  //       break;
  //     case 'sel2':
  //       existingSel2Favorite = favoriteSel2Json;
  //       existingSel2Now = nowSel2Color;
  //       break;
  //     default:
  //       print("유효하지 않은 타입입니다: $type");
  //       return;
  //   }

  //   // 업데이트된 데이터를 저장
  //   await dbHelper.saveCustomMode(
  //     mode: modeKey,
  //     bgFavorite: existingBgFavorite,
  //     bgNow: existingBgNow,
  //     sel1Favorite: existingSel1Favorite,
  //     sel1Now: existingSel1Now,
  //     sel2Favorite: existingSel2Favorite,
  //     sel2Now: existingSel2Now,
  //   );

  //   print("커스텀 모드 저장 완료: $modeKey, type: $type");
  // }

  List<Color> parseColorList(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return [];

    // JSON 문자열을 List<dynamic>으로 파싱한 후, 각 항목을 Color로 변환
    final List<dynamic> colorValues = jsonDecode(jsonString);
    return colorValues.map((value) => Color(value)).toList();
  }

  void loadCustomMode(int mode) async {
    final dbHelper = DatabaseHelper();
    String modeKey = 'custom$mode';

    // 데이터베이스에서 모드 데이터 가져오기
    final result = await dbHelper.getCustomMode(modeKey);
    if (result != null) {
      selectedBgCustomColor.value = Color(result['bgNow'] ?? 0xFFFFFF);
      customBgColors.value = parseColorList(result['bgFavorite']);
      selectedSel1CustomColor.value = Color(result['sel1Now'] ?? 0xFFFFFF);
      customSel1Colors.value = parseColorList(result['sel1Favorite']);
      selectedSel2CustomColor.value = Color(result['sel2Now'] ?? 0xFFFFFF);
      customSel2Colors.value = parseColorList(result['sel2Favorite']);
    }
  }

  void selectCustomSave(int index, String type) {
    switch (type) {
      case 'bg':
        isCustomSaveComplete.value = true;
        final newColors = [
          ...customModeModels[index].value.customBgColors,
          customModeModels[index].value.selectedBgCustomColor
        ];
        customModeModels[index].value =
            customModeModels[index].value.copyWith(customBgColors: newColors);
        break;
      case 'sel1':
        isCustomSaveComplete.value = true;
        final newColors = [
          ...customModeModels[index].value.customSel1Colors,
          customModeModels[index].value.selectedSel1CustomColor
        ];
        customModeModels[index].value =
            customModeModels[index].value.copyWith(customSel1Colors: newColors);
        break;
      case 'sel2':
        isCustomSaveComplete.value = true;
        final newColors = [
          ...customModeModels[index].value.customSel2Colors,
          customModeModels[index].value.selectedSel2CustomColor
        ];
        customModeModels[index].value =
            customModeModels[index].value.copyWith(customSel2Colors: newColors);
        break;
      default:
        return;
    }
  }

  void selectCustomRemove(int index, String type) {
    final currentModel = customModeModels[index].value;
    switch (type) {
      case 'bg':
        final updatedFavorites = List<Color>.from(currentModel.customBgColors)
          ..remove(currentModel.selectedBgCustomColor);
        customModeModels[index].value =
            currentModel.copyWith(customBgColors: updatedFavorites);
        break;
      case 'sel1':
        final updatedFavorites = List<Color>.from(currentModel.customSel1Colors)
          ..remove(currentModel.selectedSel1CustomColor);
        customModeModels[index].value =
            currentModel.copyWith(customSel1Colors: updatedFavorites);
        break;
      case 'sel2':
        final updatedFavorites = List<Color>.from(currentModel.customSel2Colors)
          ..remove(currentModel.selectedSel2CustomColor);
        customModeModels[index].value =
            currentModel.copyWith(customSel2Colors: updatedFavorites);
        break;
      default:
        return;
    }
  }

  void applyFromCustoms(int index, Color color, String type) {
    isCustomSaveComplete.value = false;
    switch (type) {
      case 'bg':
        customModeModels[index].value = customModeModels[index]
            .value
            .copyWith(selectedBgCustomColor: color);
        break;
      case 'sel1':
        customModeModels[index].value = customModeModels[index]
            .value
            .copyWith(selectedSel1CustomColor: color);
        break;
      case 'sel2':
        customModeModels[index].value = customModeModels[index]
            .value
            .copyWith(selectedSel2CustomColor: color);
        break;
      default:
        return;
    }
  }

//커스텀모드 컬러 세팅
//뮤직 모드 세팅
  void selectMusicSave(int index) {
    final currentMusic = musicModeModel[index].value;
    if (currentMusic.musicColors.contains(currentMusic.selectedMusicColor)) {
      // return;
    } else {
      isMusicSaveComplete.value = true;
      final newColors = [
        ...musicModeModel[index].value.musicColors,
        currentMusic.selectedMusicColor
      ];
      musicModeModel[index].value =
          musicModeModel[index].value.copyWith(musicColors: newColors);
    }
  }

  void selectMusicRemove(int index) {
    final currentMusic = musicModeModel[index].value;
    final updatedFavorites = List<Color>.from(currentMusic.musicColors)
      ..remove(currentMusic.selectedMusicColor);

    musicModeModel[index].value =
        musicModeModel[index].value.copyWith(musicColors: updatedFavorites);
  }

  void applyFromMusics(Color color, int index) {
    final currentMusic = musicModeModel[index].value;
    isMusicSaveComplete.value = false;
    musicModeModel[index].value =
        currentMusic.copyWith(selectedMusicColor: color);
  }

  void changeMusicMode(int newMode) async {
    int mode = newMode + 1;
    // 유효한 모드 값인지 확인 (1~4만 가능)
    if (mode < 1 || mode > 4) {
      print("유효하지 않은 뮤직 모드입니다: $mode");
      return;
    }

    // 뮤직 모드 설정 명령어 생성
    List<int> command = [
      0xEA, // Header 1
      0xBF, // Header 2
      0xCB, // CMD (뮤직 모드 변경)
      mode & 0xFF, // Sub Command (1~4 중 하나)
      0x00, // Data1
      0x00, // Data2
      0x00, // Data3
      0x00, // Data4
      0x00, // Data5
      0x00, // Data6
      0x00, // Data7
      0x00, // Data8
      0x00, // Data9
      0xEB // End
    ];
    print("뮤직모드 커맨드>>>${command}");
    // BLE 명령어 전송
    if (characteristic != null && isConnected.value) {
      try {
        await characteristic!.write(command, withoutResponse: false);
        print("뮤직 모드 $mode 변경 명령 전송 성공: $command");
      } catch (e) {
        print("뮤직 모드 $mode 변경 명령 전송 실패: $e");
      }
    } else {
      print("BLE 연결이 설정되지 않았습니다.");
    }
  }

  Future<void> applyMusicMode() async {
    // final Color selectedColor = toApplySingleColor.value;

    // RGB 값 추출
    int red = selectedColor.value.red;
    int green = selectedColor.value.green;
    int blue = selectedColor.value.blue;

    // BLE 명령 호출
    changeMusicMode(selectedMusicButtonIndex.value);
    await DatabaseHelper().saveCurrentApplyMode(3);
    currentApplyMode.value = 3;
    //디비에 모델 저장
    await saveMusicMode();
  }

  Future<void> applyCustomMode() async {
    currentApplyMode.value = 4;
    final applyModel =
        customModeModels.firstWhere((el) => el.value.apply == true).value;

    // 유효한 값인지 확인 (0x00 ~ 0xFF)
    List<int> colors = [
      applyModel.selectedBgCustomColor.red,
      applyModel.selectedBgCustomColor.green,
      applyModel.selectedBgCustomColor.blue,
      applyModel.selectedSel1CustomColor.red,
      applyModel.selectedSel1CustomColor.green,
      applyModel.selectedSel1CustomColor.blue,
      applyModel.selectedSel2CustomColor.red,
      applyModel.selectedSel2CustomColor.green,
      applyModel.selectedSel2CustomColor.blue,
    ];

    if (colors.any((color) => color < 0x00 || color > 0xFF)) {
      print("유효하지 않은 색상 값이 포함되어 있습니다: $colors");
      return;
    }

    // 커스텀 모드 색상 변경 명령어 생성
    List<int> command = [
      0xEA, // Header 1
      0xBF, // Header 2
      0xC6, // CMD (커스텀 모드 색상 변경)
      0x00, // Sub Command
      applyModel.selectedBgCustomColor.red,
      applyModel.selectedBgCustomColor.green,
      applyModel.selectedBgCustomColor.blue,
      applyModel.selectedSel1CustomColor.red,
      applyModel.selectedSel1CustomColor.green,
      applyModel.selectedSel1CustomColor.blue,
      applyModel.selectedSel2CustomColor.red,
      applyModel.selectedSel2CustomColor.green,
      applyModel.selectedSel2CustomColor.blue,
      0xEB, // End
    ];

    print("커스텀 모드 명령어 >>> ${command}");

    // BLE 명령어 전송
    if (characteristic != null && isConnected.value) {
      try {
        await saveCustomMode();
        await characteristic!.write(command, withoutResponse: false);
        print("커스텀 모드 명령 전송 성공: $command");
      } catch (e) {
        print("커스텀 모드 명령 전송 실패: $e");
      }
    } else {
      print("BLE 연결이 설정되지 않았습니다.");
    }
  }

//뮤직 모드 세팅
  void selectSave() {
    if (singleColors.contains(selectedColor.value)) {
      return;
    } else {
      isSingleSaveComplete.value = true;
      singleColors.add(selectedColor.value);
    }
  }

  void selectRemove() {
    singleColors.remove(selectedColor.value);
  }

  void updateTabIndex(int index) {
    currentTabIndex.value = index;
    print("현재 탭 인덱스: $index");
  }

  Future<void> applySingleMode(BuildContext context) async {
    try {
      // final Color selectedColor = toApplySingleColor.value;

      // RGB 값 추출
      int red = singleModeModel.value.selectedColor.red;
      int green = singleModeModel.value.selectedColor.green;
      int blue = singleModeModel.value.selectedColor.blue;
//디비에 저장
      await DatabaseHelper().saveSingleColor(
        selectedColor: singleModeModel.value.selectedColor.value.toString(),
        favoriteColors: singleModeModel.value.favoriteColors
            .map((color) => color.value.toString())
            .toList(),
      );
      // BLE 명령 호출
      changeSingleColorMode(red: red, green: green, blue: blue);
      //현재 모드 설정하는 로컬스토리지
      await DatabaseHelper().saveCurrentApplyMode(2);
      currentApplyMode.value = 2;
      Get.snackbar(
        "",
        "단색모드가 저장되었습니다.", // 메시지
        titleText: Text(
          "단색모드가 저장되었습니다.",
          style: TextStyle(color: CarsixColors.white1, fontSize: 18),
        ),
        messageText: Text(
          "단색모드가 저장되었습니다.",
          style: TextStyle(color: CarsixColors.white1, fontSize: 16),
        ),
        snackPosition: SnackPosition.BOTTOM, // Snackbar 위치
        maxWidth: MediaQuery.of(context).size.width - 20,
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        duration: Duration(seconds: 2),
      );
    } catch (e) {}
  }

  void addToSingleColors(Color color) {
    if (!singleColors.contains(color) && singleColors.length < 6) {
      singleColors.add(color);
    }
  }

  void changeCustomModeColor({
    required int backgroundRed,
    required int backgroundGreen,
    required int backgroundBlue,
    required int block1Red,
    required int block1Green,
    required int block1Blue,
    required int block2Red,
    required int block2Green,
    required int block2Blue,
  }) async {
    // RGB 값 유효성 검사 (0~255 범위)
    if ([
      backgroundRed,
      backgroundGreen,
      backgroundBlue,
      block1Red,
      block1Green,
      block1Blue,
      block2Red,
      block2Green,
      block2Blue
    ].any((value) => value < 0 || value > 255)) {
      print("유효하지 않은 RGB 값입니다.");
      return;
    }

    // 커스텀 모드 색상 변경 명령어 생성
    List<int> command = [
      0xEA, // Header 1
      0xBF, // Header 2
      0xC6, // CMD (Custom Mode 색상 변경)
      0x00, // Sub CMD (색상 변경)
      backgroundRed & 0xFF, // Data1: 배경 Red
      backgroundGreen & 0xFF, // Data2: 배경 Green
      backgroundBlue & 0xFF, // Data3: 배경 Blue
      block1Red & 0xFF, // Data4: Color Block 1 Red
      block1Green & 0xFF, // Data5: Color Block 1 Green
      block1Blue & 0xFF, // Data6: Color Block 1 Blue
      block2Red & 0xFF, // Data7: Color Block 2 Red
      block2Green & 0xFF, // Data8: Color Block 2 Green
      block2Blue & 0xFF, // Data9: Color Block 2 Blue
      0xEB // End
    ];

    if (characteristic != null && isConnected.value) {
      try {
        await characteristic!.write(command, withoutResponse: false);
        print("커스텀 모드 색상 변경 명령 전송 성공: $command");
      } catch (e) {
        print("커스텀 모드 색상 변경 명령 전송 실패: $e");
      }
    } else {
      print("BLE 연결이 설정되지 않았습니다.");
    }
  }

  // 즐겨찾기 색상 제거 함수
  void removeFromSingles(Color color) {
    singleColors.remove(color);
  }

  //cmd날릴 단색 색상
  void applyFromSingles(Color color) {
    isSingleSaveComplete.value = false;
    selectedColor.value = color;
  }

  Future<void> initCurrentMode() async {
    int? currentMode = await DatabaseHelper().getCurrentApplyMode();
    currentApplyMode.value = currentMode ?? 0;
  }

  Future<void> initMusicModes() async {
    final DatabaseHelper _dbHelper = DatabaseHelper();
    final musicModes = await _dbHelper.getMusicModes();

    if (musicModes.isNotEmpty) {
      musicModeModel = musicModes;
      print(
          "musicmodels>>>>>>>>>>>>>>>>>>>>>>>>>${musicModeModel.map((e) => e.value.apply)}");
      isMusicSaveComplete.value = false;
    }
  }

  Future<void> initCustomModes() async {
    final DatabaseHelper _dbHelper = DatabaseHelper();
    final customModes = await _dbHelper.getCustomModes();
    if (customModes.isNotEmpty) {
      customModeModels = customModes;
      isCustomSaveComplete.value = false;
    }
  }

  Future<void> initLightingMode() async {
    try {
      final DatabaseHelper _dbHelper = DatabaseHelper();
      final dbLightingModel = await _dbHelper.getLightingModel();
      // if (lightingModel.value!=null) {
      lightingModel = dbLightingModel;
      isLightingSaveComplete.value = false;
    } catch (e) {
      print("조명 모델 없음");
    }

    // }
  }

  Future<void> initDeviceInfo() async {
    final DatabaseHelper _dbHelper = DatabaseHelper();
    final deviceInfo = await _dbHelper.getDeviceInfo();
    if (deviceInfo != null) {
      print('Manufacturer: ${deviceInfo['manufacturer']}');
      manufacturerText.value = deviceInfo['manufacturer'].toString();
      manufacturerController.value.text = deviceInfo['manufacturer'].toString();
      print('Vehicle: ${deviceInfo['vehicle']}');
      vehicleText.value = deviceInfo['vehicle'].toString();
      vehicleController.value.text = deviceInfo['vehicle'].toString();
      print('License Plate: ${deviceInfo['licensePlate']}');
      licenseText.value = deviceInfo['licensePlate'].toString();
      licenseController.value.text = deviceInfo['licensePlate'].toString();
      print('Installation Place: ${deviceInfo['installationPlace']}');
      installationPlaceText.value = deviceInfo['installationPlace'].toString();
      installationPlaceController.value.text =
          deviceInfo['installationPlace'].toString();
    }
  }

  Future<void> saveDeviceInfo() async {
    final DatabaseHelper _dbHelper = DatabaseHelper();
    manufacturerText.value = manufacturerController.value.text;
    vehicleText.value = vehicleController.value.text;
    licenseText.value = licenseController.value.text;
    installationPlaceText.value = installationPlaceController.value.text;
    await _dbHelper.saveDeviceInfo(
      manufacturer: manufacturerController.value.text,
      vehicle: vehicleController.value.text,
      licensePlate: licenseController.value.text,
      installationPlace: installationPlaceController.value.text,
    );
  }

  @override
  void onInit() {
    super.onInit();
    initDeviceInfo();
    //액티브 모드 세팅
    initActiveModeSetting();
    //현재 모드
    initCurrentMode();
    //단색 모드
    initSingleMode();
    //뮤직모드
    initMusicModes();
    initCustomModes();
    initLightingMode();
    requestPermissions();
    scanAndConnect();
    changeMode(1);
  }

// BLEController에 추가된 레인보우 모드 함수
  // void sendRainbowMode() async {
  //   if (characteristic != null && isConnected.value) {
  //     List<List<int>> rainbowCommands = [
  //       [0xEA, 0xBF, 0xCA, 0x00, 0xFF, 0x00, 0x00, 0xEB], // 빨강
  //       [0xEA, 0xBF, 0xCA, 0x00, 0xFF, 0x80, 0x00, 0xEB], // 주황
  //       [0xEA, 0xBF, 0xCA, 0x00, 0xFF, 0xFF, 0x00, 0xEB], // 노랑
  //       [0xEA, 0xBF, 0xCA, 0x00, 0x00, 0xFF, 0x00, 0xEB], // 초록
  //       [0xEA, 0xBF, 0xCA, 0x00, 0x00, 0x00, 0xFF, 0xEB], // 파랑
  //       [0xEA, 0xBF, 0xCA, 0x00, 0x4B, 0x00, 0x82, 0xEB], // 남색
  //       [0xEA, 0xBF, 0xCA, 0x00, 0x80, 0x00, 0x80, 0xEB] // 보라
  //     ];

  //     for (var command in rainbowCommands) {
  //       try {
  //         await characteristic!.write(command, withoutResponse: false);
  //         print("명령 전송 성공: $command");
  //       } catch (e) {
  //         print("명령 전송 실패: $command, 오류: $e");
  //         // 명령 전송 실패 시 추가 처리 (예: 재시도 로직)
  //       }

  //       // 전송 간 짧은 지연 추가
  //       await Future.delayed(Duration(milliseconds: 500));
  //     }
  //   } else {
  //     print(
  //         "BLE 연결이 설정되지 않았습니다. characteristic: $characteristic, isConnected: ${isConnected.value}");
  //   }
  // }
  void changeSingleColorMode(
      {required int red, required int green, required int blue}) async {
    // RGB 값 유효성 검사 (0~255 범위)
    if (red < 0 ||
        red > 255 ||
        green < 0 ||
        green > 255 ||
        blue < 0 ||
        blue > 255) {
      print("유효하지 않은 RGB 값입니다: R=$red, G=$green, B=$blue");
      return;
    }

    // 단색 모드 색상 변경 명령어 생성
    List<int> command = [
      0xEA, // Header 1
      0xBF, // Header 2
      0xCA, // CMD (단색 모드 색상 변경)
      0x00, // Sub CMD (색상 변경)
      red & 0xFF, // Data1: Red 값
      green & 0xFF, // Data2: Green 값
      blue & 0xFF, // Data3: Blue 값
      0x00, // Data4
      0x00, // Data5
      0x00, // Data6
      0x00, // Data7
      0x00, // Data8
      0x00, // Data9
      0xEB // End
    ];

    if (characteristic != null && isConnected.value) {
      try {
        await characteristic!.write(command, withoutResponse: false);
        print("단색 모드 색상 변경 명령 전송 성공: $command");
      } catch (e) {
        print("단색 모드 색상 변경 명령 전송 실패: $e");
      }
    } else {
      print("BLE 연결이 설정되지 않았습니다.");
    }
  }

  void changeMode(int subCommand) async {
    // 유효한 Sub Command인지 확인
    print("모드 내에서 탭 전환>> ${subCommand}");
    updateTabIndex(subCommand);
    if (subCommand < 1 || subCommand > 4) {
      print("유효하지 않은 모드 번호입니다: $subCommand");
      return;
    }

    // 모드 변경 명령어 생성
    List<int> command = [
      0xEA, // Header 1
      0xBF, // Header 2
      0xC4, // CMD (Mode 변경)
      subCommand & 0xFF, // Sub CMD (모드 번호)
      0x00, // Data 1
      0x00, // Data 2
      0x00, // Data 3
      0x00, // Data 4
      0x00, // Data 5
      0x00, // Data 6
      0x00, // Data 7
      0x00, // Data 8
      0x00, // Data 9
      0xEB // End
    ];

    if (characteristic != null && isConnected.value) {
      try {
        await characteristic!.write(command, withoutResponse: false);
        print("모드 변경 명령 전송 성공: $command");
      } catch (e) {
        print("모드 변경 명령 전송 실패: $e");
      }
    } else {
      print("BLE 연결이 설정되지 않았습니다.");
    }
  }

  void sendActiveMode() async {
    // 모드 번호 유효성 검사
    if (selectedButtonIndex.value < 0 || selectedButtonIndex.value > 11) {
      print("유효하지 않은 모드 번호입니다: $selectedButtonIndex.value");
      return;
    }

    // CMD 값 설정
    int cmd;
    if (selectedButtonIndex.value == 0) {
      cmd = 0x0B; // Rainbow Mode CMD
    } else {
      cmd = 0xC5; // Active Mode CMD
    }

    // Sub CMD 설정 (레인보우 모드는 0 고정)
    int subCmd = selectedButtonIndex.value == 0
        ? 0x00
        : selectedButtonIndex.value & 0xFF;

    // 명령어 생성
    List<int> command = [
      0xEA, // Header 1
      0xBF, // Header 2
      cmd, // CMD (Active Mode 또는 Rainbow Mode)
      subCmd, // Sub CMD (모드 번호 또는 0)
      0x00, // Data 1
      0x00, // Data 2
      0x00, // Data 3
      0x00, // Data 4
      0x00, // Data 5
      0x00, // Data 6
      0x00, // Data 7
      0x00, // Data 8
      0x00, // Data 9
      0xEB // End
    ];

    if (characteristic != null && isConnected.value) {
      try {
        await characteristic!.write(command, withoutResponse: false);
        print(
            "${selectedButtonIndex.value == 0 ? "Rainbow" : "Active"} Mode $selectedButtonIndex.value 명령 전송 성공: $command");
        await DatabaseHelper().saveCurrentApplyMode(1);
        currentApplyMode.value = 1;
      } catch (e) {
        print(
            "${selectedButtonIndex.value == 0 ? "Rainbow" : "Active"} Mode $selectedButtonIndex.value 명령 전송 실패: $e");
      }
    } else {
      print("BLE 연결이 설정되지 않았습니다.");
    }
  }

  // LED 개수 설정 함수
  void sendLEDCountConfigToBLE(List<int> ledCounts) async {
    if (characteristic != null && isConnected.value) {
      if (ledCounts.length != 7) {
        print("LED 개수 리스트는 정확히 7개의 값을 가져야 합니다.");
        return;
      }

      List<int> command = [
        0xEA, // Header 1
        0xBF, // Header 2
        0xC1, // Command
        0x00, // Sub Command
        ...ledCounts, // Data1 ~ Data7 (각 스트립의 LED 개수)
        0x00, // Data8
        0x00, // Data9
        0xEB // End byte
      ];

      await characteristic!.write(command);
      print("BLE 명령 전송 (LED 개수 설정): $command");
    } else {
      print(
          "BLE 연결이 설정되지 않았습니다. characteristic: $characteristic, isConnected: ${isConnected.value}");
    }
  }

  void testSetStrip1LEDCount() async {
    if (characteristic != null && isConnected.value) {
      // LED 개수 설정 명령어 생성
      //앞의 여섯자리는 숫자 채워주기 안채우면 에러날가능성있음
      List<int> command = [
        0xEA, // Header 1
        0xBF, // Header 2
        0xC1, // Command for LED count setting
        0x00, // Sub Command
        0x40, // Data1: Strip1의 LED 개수 (64개)
        0x00, // Data2: Strip2의 LED 개수 (0개)
        0x00, // Data3: Strip3의 LED 개수 (0개)
        0x00, // Data4: Strip4의 LED 개수 (0개)
        0x00, // Data5: Strip5의 LED 개수 (0개)
        0x00, // Data6: Strip6의 LED 개수 (0개)
        0x00, // Data7: (0으로 설정)
        0x00, // Data8: (0으로 설정)
        0x00, // Data9: (0으로 설정)
        0xEB // End byte
      ];

      // // 명령어 전송
      // await characteristic!.write(command);
      print(
          ">>>>>>BLE 명령 전송 (Strip1 LED 64개, 나머지 0개): $command // $characteristic");
    } else {
      print(
          ">>>>>>BLE 연결이 설정되지 않았습니다. characteristic: $characteristic, isConnected: ${isConnected.value}");
    }
  }

  // 테스트 함수: 예시 명령어 전송
  void testSendLEDCountConfigExample1() {
    // 예시 1: EABFC1006464646464000000EB (각 스트립의 LED 개수 설정)
    List<int> ledCounts = [0x64, 0x64, 0x64, 0x64, 0x64, 0x40, 0x00];
    sendLEDCountConfigToBLE(ledCounts);
  }

  void sendTestStrip2DisableToBLE() async {
    if (characteristic != null && isConnected.value) {
      // strip2만 비활성화하고 나머지는 활성화하는 명령어
      List<int> testStripCommand = [
        0xEA, // Header 1
        0xBF, // Header 2
        0xC2, // Command
        0x01, // Enable (전체 명령 활성화)
        0x01, // Strip1 활성화
        0x01, // Strip2 비활성화
        0x01, // Strip3 활성화
        0x01, // Strip4 활성화
        0x01, // Strip5 활성화
        0x01, // Strip6 활성화
        0x01, // Strip7 활성화
        0x00, // Data8 (0으로 설정)
        0x00, // Data9 (0으로 설정)
        0xEB // End byte
      ];

      try {
        // 명령어 전송 (with response) 및 지연 추가
        await characteristic!.write(testStripCommand, withoutResponse: false);
        print("BLE 명령 전송 (strip2 비활성화): $testStripCommand");

        // 전송 후 짧은 지연
        await Future.delayed(Duration(milliseconds: 500));
      } catch (e) {
        print("명령 전송 중 오류 발생: $e");
      }
    } else {
      print(
          "BLE 연결이 설정되지 않았습니다. characteristic: $characteristic, isConnected: ${isConnected.value}");
    }
  }

  void sendActiveModeToBLE(int command) {
    if (characteristic != null && isConnected.value) {
      List<int> protocolCommand = [
        0xEA, // Header
        0xBF, // Header 2
        command, // Command
        0x00, // Sub Command
        0xEB // End byte
      ];
      characteristic!.write(protocolCommand);
      print("BLE 명령 전송 in sendCommandToBLE : $protocolCommand");
    } else {
      print("BLE 연결이 설정되지 않았습니다.$characteristic // ${isConnected.value}");
    }
  }

  void requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    statuses.forEach((permission, status) {
      print('$permission: $status');
    });

    if (statuses[Permission.bluetoothConnect] == PermissionStatus.granted &&
        statuses[Permission.bluetoothScan] == PermissionStatus.granted &&
        statuses[Permission.locationWhenInUse] == PermissionStatus.granted) {
      print("모든 BLE 권한이 허용되었습니다.");
    } else {
      print("BLE 권한이 허용되지 않았습니다.");
    }
  }

  void scanAndConnect() {
    if (isScanning.value) {
      print("스캔이 이미 진행 중입니다.");
      return;
    }

    isScanning.value = true;
    flutterBlue.startScan(timeout: Duration(seconds: 4)).catchError((e) {
      print("BLE 스캔 오류: $e");
    });

    flutterBlue.scanResults.listen((results) {
      print("연결결과00--->>>$results");
      for (ScanResult result in results) {
        if (result.advertisementData.localName == deviceName) {
          flutterBlue.stopScan();
          isScanning.value = false;
          print("연결결과11--->>>$result");
          connectToDevice(result.device);
          break;
        }
      }
    });

    flutterBlue.isScanning.listen((scanning) {
      isScanning.value = scanning;
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      isConnected.value = true;
      connectedDevice = device;
      print("BLE 기기와 연결되었습니다.$connectedDevice");

      // 연결 후에 원하는 characteristic 찾기
      discoverServices();
    } catch (e) {
      print("연결 오류: $e");
    }
  }

  void discoverServices() async {
    if (connectedDevice == null) return;

    List<BluetoothService> services = await connectedDevice!.discoverServices();
    print("발견된 서비스 목록: $services");

    for (var service in services) {
      print("서비스 확인 중: ${service.uuid}");

      for (var char in service.characteristics) {
        // RX Characteristic UUID로 설정
        if (char.uuid.toString() == "6e400002-b5a3-f393-e0a9-e50e24dcca9e") {
          characteristic = char;
          print("필요한 characteristic 발견: ${char.uuid}");

          print("  >>>>>>>>>>속성: ${char.uuid} // ${char.properties}");
          break;
        }
      }

      if (characteristic != null) break; // 원하는 characteristic을 찾았으므로 루프 종료
    }

    if (characteristic == null) {
      print("필요한 characteristic을 찾지 못했습니다.");
    } else {
      print("BLE characteristic이 설정되었습니다.");
    }
  }

  // 속도 설정 값을 BLE로 전송하는 함수
  void sendSpeedToBLE() {
    if (characteristic == null || !isConnected.value) {
      print("BLE에 연결되지 않았거나 특성이 설정되지 않았습니다. ${isConnected.value}");
      return;
    }

    List<int> command = [
      0xEA, // Header 1
      0xBF, // Header 2
      0xC1, // CMD for speed 설정 (예시)
      0x00, // Sub CMD (예시)
      speedValue.value.toInt(), // 속도 값
      0xEB // End Byte
    ];

    characteristic!.write(command);
    print("속도 값을 BLE로 전송: $command");
  }

  // 슬라이더 값이 변경될 때 호출할 함수
  void updateSpeedValue(double value) {
    speedValue.value = value;
    sendSpeedToBLE(); // 속도 값을 전송
  }

  void disconnect() {
    connectedDevice?.disconnect();
    isConnected.value = false;
    print("BLE 연결이 종료되었습니다.");
  }
}
