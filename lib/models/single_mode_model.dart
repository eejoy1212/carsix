import 'dart:convert';
import 'package:flutter/material.dart';

class SingleMode {
  final Color selectedColor;
  final List<Color> favoriteColors;

  SingleMode({
    required this.selectedColor,
    required this.favoriteColors,
  });

  // copyWith 메서드
  SingleMode copyWith({
    Color? selectedColor,
    List<Color>? favoriteColors,
  }) {
    return SingleMode(
      selectedColor: selectedColor ?? this.selectedColor,
      favoriteColors: favoriteColors ?? this.favoriteColors,
    );
  }

  // JSON 직렬화를 위한 팩토리 생성자
  factory SingleMode.fromJson(Map<String, dynamic> json) {
    return SingleMode(
      selectedColor: Color(int.tryParse(json['selectedColor']) ?? 0x00000000),
      favoriteColors: (json['favoriteColors'] as List<dynamic>?)
              ?.map((color) => Color(int.tryParse(color) ?? 0x00000000))
              .toList() ??
          [],
    );
  }

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'selectedColor': selectedColor.value,
      'favoriteColors': favoriteColors.map((color) => color.value).toList(),
    };
  }
}
