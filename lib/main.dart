import 'dart:io';

import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/modules/bottom_navbar/controllers/bottom_navbar_controller.dart';
import 'package:carsix/modules/favorite/controllers/favorite_controller.dart';
import 'package:carsix/modules/loading/controllers/loading_controllers.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/routes/app_pages.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Desktop 환경이라면 sqflite_common_ffi를 초기화
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MainController());
  Get.put(BLEController());
  Get.put(ThemeController());
  Get.put(NavigationController());
  Get.put(FavoriteController());
  Get.put(LoadingController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent, // Scaffold의 기본 배경 투명 처리
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent, // 동일한 설정
      ),
      themeMode: ThemeMode.dark,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black, // #000000
                Colors.black, // #000000
                Color(0xFF2B2B2B), // #2B2B2B
              ],
            ),
          ),
          child: child, // 전체 앱 위젯을 포함
        );
      },
    );
  }
}
