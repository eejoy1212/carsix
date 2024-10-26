import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light, // 기본 다크 모 드 설정
    colorScheme: ColorScheme.fromSeed(
      background: CarsixColors.primaryRed,
      seedColor: CarsixColors.primaryRed,
      brightness: Brightness.light,
      // 여기에서 다크 모드를 명시적으로 설정
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        height: 1.6,
        color: CarsixColors.white1,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        letterSpacing: 2,
      ),
      headline1: TextStyle(
        height: 1.6,
        color: CarsixColors.white1,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        letterSpacing: 2,
      ),
    )
    // useMaterial3: true,
    );

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, // 기본 다크 모드 설정
    colorScheme: ColorScheme.fromSeed(
      background: CarsixColors.black1,
      seedColor: CarsixColors.primaryRed,
      brightness: Brightness.dark, // 여기에서 다크 모드를 명시적으로 설정
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        height: 1.6,
        color: CarsixColors.white1,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        letterSpacing: 2,
      ),
      headline1: TextStyle(
        height: 1.6,
        color: CarsixColors.white1,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        letterSpacing: 2,
      ),
      bodyText1: TextStyle(),
    )
    // useMaterial3: true,
    );
