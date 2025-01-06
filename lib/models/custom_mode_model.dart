import 'package:flutter/material.dart';

class CustomMode {
  final bool apply; // 적용 여부
  final Color selectedBgCustomColor; // 선택된 배경 커스텀 색상
  final List<Color> customBgColors; // 배경 커스텀 색상 리스트
  final Color selectedSel1CustomColor; // 선택된 Sel1 커스텀 색상
  final List<Color> customSel1Colors; // Sel1 커스텀 색상 리스트
  final Color selectedSel2CustomColor; // 선택된 Sel2 커스텀 색상
  final List<Color> customSel2Colors; // Sel2 커스텀 색상 리스트
  final double bgBright; // 배경 밝기
  final double bgVelocity; // 배경 속도
  final double sel1Bright; // Sel1 밝기
  final double sel1Velocity; // Sel1 속도
  final double sel2Bright; // Sel2 밝기
  final double sel2Velocity; // Sel2 속도

  CustomMode({
    required this.apply,
    required this.selectedBgCustomColor,
    required this.customBgColors,
    required this.selectedSel1CustomColor,
    required this.customSel1Colors,
    required this.selectedSel2CustomColor,
    required this.customSel2Colors,
    required this.bgBright,
    required this.bgVelocity,
    required this.sel1Bright,
    required this.sel1Velocity,
    required this.sel2Bright,
    required this.sel2Velocity,
  });

  // copyWith 메서드
  CustomMode copyWith({
    bool? apply,
    Color? selectedBgCustomColor,
    List<Color>? customBgColors,
    Color? selectedSel1CustomColor,
    List<Color>? customSel1Colors,
    Color? selectedSel2CustomColor,
    List<Color>? customSel2Colors,
    double? bgBright,
    double? bgVelocity,
    double? sel1Bright,
    double? sel1Velocity,
    double? sel2Bright,
    double? sel2Velocity,
  }) {
    return CustomMode(
      apply: apply ?? this.apply,
      selectedBgCustomColor:
          selectedBgCustomColor ?? this.selectedBgCustomColor,
      customBgColors: customBgColors ?? this.customBgColors,
      selectedSel1CustomColor:
          selectedSel1CustomColor ?? this.selectedSel1CustomColor,
      customSel1Colors: customSel1Colors ?? this.customSel1Colors,
      selectedSel2CustomColor:
          selectedSel2CustomColor ?? this.selectedSel2CustomColor,
      customSel2Colors: customSel2Colors ?? this.customSel2Colors,
      bgBright: bgBright ?? this.bgBright,
      bgVelocity: bgVelocity ?? this.bgVelocity,
      sel1Bright: sel1Bright ?? this.sel1Bright,
      sel1Velocity: sel1Velocity ?? this.sel1Velocity,
      sel2Bright: sel2Bright ?? this.sel2Bright,
      sel2Velocity: sel2Velocity ?? this.sel2Velocity,
    );
  }

  // JSON 직렬화
  Map<String, dynamic> toJson() {
    return {
      'apply': apply,
      'selectedBgCustomColor': selectedBgCustomColor.value,
      'customBgColors': customBgColors.map((color) => color.value).toList(),
      'selectedSel1CustomColor': selectedSel1CustomColor.value,
      'customSel1Colors': customSel1Colors.map((color) => color.value).toList(),
      'selectedSel2CustomColor': selectedSel2CustomColor.value,
      'customSel2Colors': customSel2Colors.map((color) => color.value).toList(),
      'bgBright': bgBright,
      'bgVelocity': bgVelocity,
      'sel1Bright': sel1Bright,
      'sel1Velocity': sel1Velocity,
      'sel2Bright': sel2Bright,
      'sel2Velocity': sel2Velocity,
    };
  }

  // JSON 역직렬화
  factory CustomMode.fromJson(Map<String, dynamic> json) {
    return CustomMode(
      apply: json['apply'] as bool,
      selectedBgCustomColor: Color(json['selectedBgCustomColor']),
      customBgColors: (json['customBgColors'] as List<dynamic>)
          .map((colorValue) => Color(colorValue))
          .toList(),
      selectedSel1CustomColor: Color(json['selectedSel1CustomColor']),
      customSel1Colors: (json['customSel1Colors'] as List<dynamic>)
          .map((colorValue) => Color(colorValue))
          .toList(),
      selectedSel2CustomColor: Color(json['selectedSel2CustomColor']),
      customSel2Colors: (json['customSel2Colors'] as List<dynamic>)
          .map((colorValue) => Color(colorValue))
          .toList(),
      bgBright: json['bgBright'].toDouble(),
      bgVelocity: json['bgVelocity'].toDouble(),
      sel1Bright: json['sel1Bright'].toDouble(),
      sel1Velocity: json['sel1Velocity'].toDouble(),
      sel2Bright: json['sel2Bright'].toDouble(),
      sel2Velocity: json['sel2Velocity'].toDouble(),
    );
  }
}
