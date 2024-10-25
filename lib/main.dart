import 'package:carsix/const/color.dart';
import 'package:carsix/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX App',
      theme: ThemeData(
        brightness: Brightness.dark, // 기본 다크 모드 설정
        colorScheme: ColorScheme.fromSeed(
          background: CarsixColors.black1,
          seedColor: CarsixColors.primaryRed,
          brightness: Brightness.dark, // 여기에서 다크 모드를 명시적으로 설정
        ),
        // useMaterial3: true,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
