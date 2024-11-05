import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MainController extends GetxController {
  // 스위치 상태를 관리하는 변수
  var isAutoBrightOn = false.obs;
  var currentIndex = 0.obs;

  // 레인지 슬라이더 값 상태를 관리하는 변수
  var currentRangeValues = RangeValues(20, 80).obs;
  // 선택된 색상 변수
  var selectedColor = CarsixColors.primaryRed.obs;
  // 선택된 버튼 인덱스 (-1은 선택 안된 상태를 의미)
  RxInt selectedButtonIndex = (-1).obs;
  // 모드 선택 상태 변수
  RxList<bool> isSelectedModes = List.generate(11, (_) => false).obs;
  // 즐겨찾기 컬러
  RxList<Color> favoriteColors = RxList.empty();
  // 뮤직 컬러
  RxList<Color> musicColors = RxList.empty();
  // 웰컴 컬러
  RxList<Color> welcomeColors = RxList.empty();
  // 모드 1~4
  RxString selectedMode = RxString("모드1");
  RxDouble musicSensitivity = RxDouble(0.0);

  // 디바이스 설정 페이지
  // Text controllers
  final manufacturerController = TextEditingController();
  final vehicleController = TextEditingController();
  final licensePlateController = TextEditingController();
  final installationPlaceController = TextEditingController();

  Future<Database>? _database;

  @override
  void onInit() {
    super.onInit();
    _database = _initDatabase(); // 비동기적으로 데이터베이스 초기화
    loadDeviceInfo(); // 데이터 초기화
  }

  @override
  void onClose() {
    // Dispose controllers when done
    manufacturerController.dispose();
    vehicleController.dispose();
    licensePlateController.dispose();
    installationPlaceController.dispose();
    super.onClose();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'device_info.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE device(id INTEGER PRIMARY KEY, manufacturer TEXT, vehicle TEXT, licensePlate TEXT, installationPlace TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> saveDeviceInfo() async {
    final db = await _database; // 데이터베이스가 초기화되기를 기다림
    await db!.insert(
      'device',
      {
        'manufacturer': manufacturerController.text,
        'vehicle': vehicleController.text,
        'licensePlate': licensePlateController.text,
        'installationPlace': installationPlaceController.text,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    Get.back(); // 이전 화면으로 이동
  }

  Future<void> loadDeviceInfo() async {
    final db = await _database;
    final List<Map<String, dynamic>> deviceInfo = await db!.query('device');
    if (deviceInfo.isNotEmpty) {
      manufacturerController.text = deviceInfo[0]['manufacturer'] ?? '';
      vehicleController.text = deviceInfo[0]['vehicle'] ?? '';
      licensePlateController.text = deviceInfo[0]['licensePlate'] ?? '';
      installationPlaceController.text =
          deviceInfo[0]['installationPlace'] ?? '';
    }
  }

  Future<List<Map<String, dynamic>>> getDeviceInfo() async {
    final db = await _database; // 데이터베이스가 초기화되기를 기다림
    final List<Map<String, dynamic>> deviceInfo = await db!.query('device');
    if (deviceInfo.isNotEmpty) {
      print("Device Information:");
      print("Manufacturer: ${deviceInfo[0]['manufacturer']}");
      print("Vehicle: ${deviceInfo[0]['vehicle']}");
      print("License Plate: ${deviceInfo[0]['licensePlate']}");
      print("Installation Place: ${deviceInfo[0]['installationPlace']}");
      return deviceInfo;
    } else {
      print("No device information found.");
      return []; // 데이터가 없을 때 빈 리스트 반환
    }
  }

  // 기존 디바이스 정보를 업데이트하는 메서드
  Future<void> updateDeviceInfo() async {
    final db = await _database;
    await db!.update(
      'device',
      {
        'manufacturer': manufacturerController.text,
        'vehicle': vehicleController.text,
        'licensePlate': licensePlateController.text,
        'installationPlace': installationPlaceController.text,
      },
      where: "id = ?",
      whereArgs: [1], // 단일 레코드를 업데이트하려면 ID가 필요합니다
    );
    // Get.back(); // 이전 화면으로 이동
  }

  // 스위치 상태 변경 함수
  void toggleAutoBright(bool value) {
    isAutoBrightOn.value = value;
  }

  // 레인지 슬라이더 값 변경 함수
  void updateRangeValues(RangeValues values) {
    currentRangeValues.value = values;
  }

  // 뮤직 색상 추가 함수
  void addToMusics(Color color) {
    if (!musicColors.contains(color) && musicColors.length < 8) {
      musicColors.add(color);
    }
  }

  // 뮤직 색상 제거 함수
  void removeFromMusics(Color color) {
    musicColors.remove(color);
  }

  // 웰컴 색상 추가 함수
  void addToWelcomes(Color color) {
    if (!welcomeColors.contains(color) && welcomeColors.length < 3) {
      welcomeColors.add(color);
    }
  }

  // 웰컴 색상 제거 함수
  void removeFromWelcomes(Color color) {
    welcomeColors.remove(color);
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
