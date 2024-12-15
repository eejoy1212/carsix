import 'package:flutter/material.dart';

class SelectedColorChip extends StatelessWidget {
  const SelectedColorChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 18, // 원형 컨테이너의 가로 길이
        height: 18, // 원형 컨테이너의 세로 길이
        decoration: BoxDecoration(
          color: Colors.white, // 컨테이너 배경색: 흰색
          shape: BoxShape.circle, // 원형
          boxShadow: [
            BoxShadow(
              color: const Color(0x40000000), // 그림자 색상 (#00000040)
              offset: const Offset(4, 4), // 가로(x), 세로(y) 방향으로 4px 이동
              blurRadius: 4, // 그림자의 흐림 정도
              spreadRadius: 0, // 그림자 확산 정도
            ),
          ],
        ),
      ),
    );
  }
}
