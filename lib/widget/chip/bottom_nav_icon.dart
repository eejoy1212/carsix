import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum BottomNavIconType { home, led, car, color, settings, left }

class BottomNavIcon extends StatelessWidget {
  final BottomNavIconType iconType; // 열거형 타입 사용
  final bool isActive;
  const BottomNavIcon(
      {super.key, required this.iconType, required this.isActive});

  @override
  Widget build(BuildContext context) {
    // iconType에 따라 파일 경로를 동적으로 설정
    String getIconPath(BottomNavIconType type) {
      switch (type) {
        case BottomNavIconType.home:
          return 'assets/images/home-icon.svg';
        case BottomNavIconType.led:
          return 'assets/images/led-icon.svg';
        case BottomNavIconType.car:
          return 'assets/images/car-icon.svg';
        case BottomNavIconType.color:
          return 'assets/images/color-filter-icon.svg';
        case BottomNavIconType.settings:
          return 'assets/images/settings-icon.svg';
        case BottomNavIconType.left:
          return 'assets/images/nav-arrow-left.svg';
        default:
          return 'assets/images/home-icon.svg';
      }
    }

    return SvgPicture.asset(
      getIconPath(iconType), // 동적으로 아이콘 경로 선택
      colorFilter: ColorFilter.mode(
        isActive ? CarsixColors.white1 : Color(0xFF696969), // #696969 색상 적용
        BlendMode.srcIn, // SVG 내부 색상 변경
      ),
    );
  }
}
