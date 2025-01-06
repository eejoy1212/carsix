import 'package:flutter/material.dart';

class MusicMode {
  final Color selectedMusicColor; // 선택된 음악 색상
  final List<Color> musicColors; // 음악 색상 리스트
  final double musicBright; // 음악 민감도
  final bool apply;
  MusicMode({
    required this.selectedMusicColor,
    required this.musicColors,
    required this.musicBright,
    required this.apply,
  });

  // copyWith 메서드
  MusicMode copyWith({
    Color? selectedMusicColor,
    List<Color>? musicColors,
    double? musicBright,
    bool? apply,
  }) {
    return MusicMode(
      selectedMusicColor: selectedMusicColor ?? this.selectedMusicColor,
      musicColors: musicColors ?? this.musicColors,
      musicBright: musicBright ?? this.musicBright,
      apply: apply ?? this.apply,
    );
  }

  // JSON 직렬화 (optional: 필요 시 추가)
  Map<String, dynamic> toJson() {
    return {
      'selectedMusicColor': selectedMusicColor.value,
      'musicColors': musicColors.map((color) => color.value).toList(),
      'musicBright': musicBright,
      'apply': apply,
    };
  }

  // JSON 역직렬화 (optional: 필요 시 추가)
  factory MusicMode.fromJson(Map<String, dynamic> json) {
    return MusicMode(
      selectedMusicColor: Color(json['selectedMusicColor']),
      musicColors: (json['musicColors'] as List<dynamic>)
          .map((colorValue) => Color(colorValue))
          .toList(),
      musicBright: json['musicBright'].toDouble(),
      apply: json['apply'] as bool,
    );
  }
}
