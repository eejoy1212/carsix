import 'package:flutter/material.dart';

class ColorChip extends StatelessWidget {
  final Color selected;
  const ColorChip({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36, // 원하는 너비
      height: 36, // 원하는 높이
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected, // 배경색
        boxShadow: [
          const BoxShadow(
            color: const Color(0x40000000),
          ),
          // 일반 그림자
          BoxShadow(
            color: const Color(0x40000000), // #00000040
            offset: const Offset(-4, -4), // 안쪽 그림자 효과를 만들기 위한 방향
            blurRadius: 4,
            spreadRadius: -4,
            // inset: true, // inset 효과를 직접 구현하려면 CustomPainter로 추가 작업 필요
          ),
        ],
      ),
    );
  }
}
