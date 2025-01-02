import 'dart:convert';
import 'package:flutter/material.dart';

class ActiveMode {
  final Color welcome1;
  final List<Color> welcome1Favorites;
  final Color welcome2;
  final List<Color> welcome2Favorites;
  final String weather; // "맑음", "흐림", "비", "눈"
  final Color goodbye1;
  final List<Color> goodbye1Favorites;
  final Color goodbye2;
  final List<Color> goodbye2Favorites;
  final Color goodbye3;
  final List<Color> goodbye3Favorites;
  final String nowSelectedCeremony; // 추가된 변수

  ActiveMode({
    required this.welcome1,
    required this.welcome1Favorites,
    required this.welcome2,
    required this.welcome2Favorites,
    required this.weather,
    required this.goodbye1,
    required this.goodbye1Favorites,
    required this.goodbye2,
    required this.goodbye2Favorites,
    required this.goodbye3,
    required this.goodbye3Favorites,
    required this.nowSelectedCeremony,
  });

  ActiveMode copyWith({
    Color? welcome1,
    List<Color>? welcome1Favorites,
    Color? welcome2,
    List<Color>? welcome2Favorites,
    String? weather,
    Color? goodbye1,
    List<Color>? goodbye1Favorites,
    Color? goodbye2,
    List<Color>? goodbye2Favorites,
    Color? goodbye3,
    List<Color>? goodbye3Favorites,
    String? nowSelectedCeremony, // copyWith에 추가
  }) {
    return ActiveMode(
      welcome1: welcome1 ?? this.welcome1,
      welcome1Favorites: welcome1Favorites ?? this.welcome1Favorites,
      welcome2: welcome2 ?? this.welcome2,
      welcome2Favorites: welcome2Favorites ?? this.welcome2Favorites,
      weather: weather ?? this.weather,
      goodbye1: goodbye1 ?? this.goodbye1,
      goodbye1Favorites: goodbye1Favorites ?? this.goodbye1Favorites,
      goodbye2: goodbye2 ?? this.goodbye2,
      goodbye2Favorites: goodbye2Favorites ?? this.goodbye2Favorites,
      goodbye3: goodbye3 ?? this.goodbye3,
      goodbye3Favorites: goodbye3Favorites ?? this.goodbye3Favorites,
      nowSelectedCeremony: nowSelectedCeremony ?? this.nowSelectedCeremony,
    );
  }

  // JSON 직렬화를 위한 팩토리 생성자
  factory ActiveMode.fromJson(Map<String, dynamic> json) {
    List<Color> parseColorListForActiveMode(dynamic jsonData) {
      if (jsonData == null) return [];
      if (jsonData is String) {
        final List<dynamic> colorValues = jsonDecode(jsonData);
        return colorValues.map((value) => Color(value)).toList();
      } else if (jsonData is List<dynamic>) {
        return jsonData
            .map((value) => Color(int.tryParse(
                    value.replaceAll('Color(', '').replaceAll(')', '')) ??
                0x00000000))
            .toList();
      } else {
        throw TypeError();
      }
    }

    return ActiveMode(
      welcome1: Color(int.tryParse(
              json['welcome1']?.replaceAll('Color(', '').replaceAll(')', '') ??
                  '0') ??
          0x00000000),
      welcome1Favorites: parseColorListForActiveMode(json['welcome1Favorites']),
      welcome2: Color(int.tryParse(
              json['welcome2']?.replaceAll('Color(', '').replaceAll(')', '') ??
                  '0') ??
          0x00000000),
      welcome2Favorites: parseColorListForActiveMode(json['welcome2Favorites']),
      weather: json['weather'] ?? '',
      goodbye1: Color(int.tryParse(
              json['goodbye1']?.replaceAll('Color(', '').replaceAll(')', '') ??
                  '0') ??
          0x00000000),
      goodbye1Favorites: parseColorListForActiveMode(json['goodbye1Favorites']),
      goodbye2: Color(int.tryParse(
              json['goodbye2']?.replaceAll('Color(', '').replaceAll(')', '') ??
                  '0') ??
          0x00000000),
      goodbye2Favorites: parseColorListForActiveMode(json['goodbye2Favorites']),
      goodbye3: Color(int.tryParse(
              json['goodbye3']?.replaceAll('Color(', '').replaceAll(')', '') ??
                  '0') ??
          0x00000000),
      goodbye3Favorites: parseColorListForActiveMode(json['goodbye3Favorites']),
      nowSelectedCeremony: json['now_selected_ceremony'] ?? '', // 추가된 변수
    );
  }

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'welcome1': welcome1.value.toRadixString(16),
      'welcome1Favorites': welcome1Favorites
          .map((color) => color.value.toRadixString(16))
          .toList(),
      'welcome2': welcome2.value.toRadixString(16),
      'welcome2Favorites': welcome2Favorites
          .map((color) => color.value.toRadixString(16))
          .toList(),
      'weather': weather,
      'goodbye1': goodbye1.value.toRadixString(16),
      'goodbye1Favorites': goodbye1Favorites
          .map((color) => color.value.toRadixString(16))
          .toList(),
      'goodbye2': goodbye2.value.toRadixString(16),
      'goodbye2Favorites': goodbye2Favorites
          .map((color) => color.value.toRadixString(16))
          .toList(),
      'goodbye3': goodbye3.value.toRadixString(16),
      'goodbye3Favorites': goodbye3Favorites
          .map((color) => color.value.toRadixString(16))
          .toList(),
      'nowSelectedCeremony': nowSelectedCeremony, // 추가된 변수
    };
  }
}
