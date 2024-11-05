import 'dart:io';

import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/routes/app_pages.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Desktop 환경이라면 sqflite_common_ffi를 초기화
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();

  final themeController = Get.put(ThemeController());
  final bleController = Get.put(BLEController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GetX App',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        ));
  }
}
