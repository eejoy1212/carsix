import 'package:carsix/const/color.dart';
import 'package:carsix/routes/app_pages.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final themeController = Get.put(ThemeController());
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
