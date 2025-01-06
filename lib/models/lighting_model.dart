import 'package:flutter/material.dart';

class LightingModel {
  final Color leftCenterColor;
  final double leftCenterBright;
  final List<Color> leftCenterFavorites; // 즐겨찾기 컬러 리스트

  final Color rightCenterColor;
  final double rightCenterBright;
  final List<Color> rightCenterFavorites; // 즐겨찾기 컬러 리스트

  final Color leftFirstDriverColor;
  final double leftFirstDriverBright;
  final List<Color> leftFirstDriverFavorites; // 즐겨찾기 컬러 리스트

  final Color rightFirstPassengerColor;
  final double rightFirstPassengerBright;
  final List<Color> rightFirstPassengerFavorites; // 즐겨찾기 컬러 리스트

  final Color leftSecondDriverColor;
  final double leftSecondDriverBright;
  final List<Color> leftSecondDriverFavorites; // 즐겨찾기 컬러 리스트

  final Color rightSecondPassengerColor;
  final double rightSecondPassengerBright;
  final List<Color> rightSecondPassengerFavorites; // 즐겨찾기 컬러 리스트

  LightingModel({
    required this.leftCenterColor,
    required this.leftCenterBright,
    required this.leftCenterFavorites,
    required this.rightCenterColor,
    required this.rightCenterBright,
    required this.rightCenterFavorites,
    required this.leftFirstDriverColor,
    required this.leftFirstDriverBright,
    required this.leftFirstDriverFavorites,
    required this.rightFirstPassengerColor,
    required this.rightFirstPassengerBright,
    required this.rightFirstPassengerFavorites,
    required this.leftSecondDriverColor,
    required this.leftSecondDriverBright,
    required this.leftSecondDriverFavorites,
    required this.rightSecondPassengerColor,
    required this.rightSecondPassengerBright,
    required this.rightSecondPassengerFavorites,
  });

  // copyWith 메서드
  LightingModel copyWith({
    Color? leftCenterColor,
    double? leftCenterBright,
    List<Color>? leftCenterFavorites,
    Color? rightCenterColor,
    double? rightCenterBright,
    List<Color>? rightCenterFavorites,
    Color? leftFirstDriverColor,
    double? leftFirstDriverBright,
    List<Color>? leftFirstDriverFavorites,
    Color? rightFirstPassengerColor,
    double? rightFirstPassengerBright,
    List<Color>? rightFirstPassengerFavorites,
    Color? leftSecondDriverColor,
    double? leftSecondDriverBright,
    List<Color>? leftSecondDriverFavorites,
    Color? rightSecondPassengerColor,
    double? rightSecondPassengerBright,
    List<Color>? rightSecondPassengerFavorites,
  }) {
    return LightingModel(
      leftCenterColor: leftCenterColor ?? this.leftCenterColor,
      leftCenterBright: leftCenterBright ?? this.leftCenterBright,
      leftCenterFavorites: leftCenterFavorites ?? this.leftCenterFavorites,
      rightCenterColor: rightCenterColor ?? this.rightCenterColor,
      rightCenterBright: rightCenterBright ?? this.rightCenterBright,
      rightCenterFavorites: rightCenterFavorites ?? this.rightCenterFavorites,
      leftFirstDriverColor: leftFirstDriverColor ?? this.leftFirstDriverColor,
      leftFirstDriverBright:
          leftFirstDriverBright ?? this.leftFirstDriverBright,
      leftFirstDriverFavorites:
          leftFirstDriverFavorites ?? this.leftFirstDriverFavorites,
      rightFirstPassengerColor:
          rightFirstPassengerColor ?? this.rightFirstPassengerColor,
      rightFirstPassengerBright:
          rightFirstPassengerBright ?? this.rightFirstPassengerBright,
      rightFirstPassengerFavorites:
          rightFirstPassengerFavorites ?? this.rightFirstPassengerFavorites,
      leftSecondDriverColor:
          leftSecondDriverColor ?? this.leftSecondDriverColor,
      leftSecondDriverBright:
          leftSecondDriverBright ?? this.leftSecondDriverBright,
      leftSecondDriverFavorites:
          leftSecondDriverFavorites ?? this.leftSecondDriverFavorites,
      rightSecondPassengerColor:
          rightSecondPassengerColor ?? this.rightSecondPassengerColor,
      rightSecondPassengerBright:
          rightSecondPassengerBright ?? this.rightSecondPassengerBright,
      rightSecondPassengerFavorites:
          rightSecondPassengerFavorites ?? this.rightSecondPassengerFavorites,
    );
  }

  // JSON 직렬화
  Map<String, dynamic> toJson() {
    return {
      'leftCenterColor': leftCenterColor.value,
      'leftCenterBright': leftCenterBright,
      'leftCenterFavorites':
          leftCenterFavorites.map((color) => color.value).toList(),
      'rightCenterColor': rightCenterColor.value,
      'rightCenterBright': rightCenterBright,
      'rightCenterFavorites':
          rightCenterFavorites.map((color) => color.value).toList(),
      'leftFirstDriverColor': leftFirstDriverColor.value,
      'leftFirstDriverBright': leftFirstDriverBright,
      'leftFirstDriverFavorites':
          leftFirstDriverFavorites.map((color) => color.value).toList(),
      'rightFirstPassengerColor': rightFirstPassengerColor.value,
      'rightFirstPassengerBright': rightFirstPassengerBright,
      'rightFirstPassengerFavorites':
          rightFirstPassengerFavorites.map((color) => color.value).toList(),
      'leftSecondDriverColor': leftSecondDriverColor.value,
      'leftSecondDriverBright': leftSecondDriverBright,
      'leftSecondDriverFavorites':
          leftSecondDriverFavorites.map((color) => color.value).toList(),
      'rightSecondPassengerColor': rightSecondPassengerColor.value,
      'rightSecondPassengerBright': rightSecondPassengerBright,
      'rightSecondPassengerFavorites':
          rightSecondPassengerFavorites.map((color) => color.value).toList(),
    };
  }

  // JSON 역직렬화
  factory LightingModel.fromJson(Map<String, dynamic> json) {
    return LightingModel(
      leftCenterColor: Color(json['leftCenterColor']),
      leftCenterBright: json['leftCenterBright'].toDouble(),
      leftCenterFavorites: (json['leftCenterFavorites'] as List<dynamic>)
          .map((colorValue) => Color(colorValue))
          .toList(),
      rightCenterColor: Color(json['rightCenterColor']),
      rightCenterBright: json['rightCenterBright'].toDouble(),
      rightCenterFavorites: (json['rightCenterFavorites'] as List<dynamic>)
          .map((colorValue) => Color(colorValue))
          .toList(),
      leftFirstDriverColor: Color(json['leftFirstDriverColor']),
      leftFirstDriverBright: json['leftFirstDriverBright'].toDouble(),
      leftFirstDriverFavorites:
          (json['leftFirstDriverFavorites'] as List<dynamic>)
              .map((colorValue) => Color(colorValue))
              .toList(),
      rightFirstPassengerColor: Color(json['rightFirstPassengerColor']),
      rightFirstPassengerBright: json['rightFirstPassengerBright'].toDouble(),
      rightFirstPassengerFavorites:
          (json['rightFirstPassengerFavorites'] as List<dynamic>)
              .map((colorValue) => Color(colorValue))
              .toList(),
      leftSecondDriverColor: Color(json['leftSecondDriverColor']),
      leftSecondDriverBright: json['leftSecondDriverBright'].toDouble(),
      leftSecondDriverFavorites:
          (json['leftSecondDriverFavorites'] as List<dynamic>)
              .map((colorValue) => Color(colorValue))
              .toList(),
      rightSecondPassengerColor: Color(json['rightSecondPassengerColor']),
      rightSecondPassengerBright: json['rightSecondPassengerBright'].toDouble(),
      rightSecondPassengerFavorites:
          (json['rightSecondPassengerFavorites'] as List<dynamic>)
              .map((colorValue) => Color(colorValue))
              .toList(),
    );
  }
}
