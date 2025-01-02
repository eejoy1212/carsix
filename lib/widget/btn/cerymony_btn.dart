import 'package:carsix/widget/chip/color_chip.dart';
import 'package:flutter/material.dart';

class CerymonyBtn extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double width;
  final Color selectedColor;
  const CerymonyBtn({
    Key? key,
    required this.title,
    required this.onTap,
    this.width = 110,
    required this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width, // 너비
        height: 48, // 높이
        // padding: const EdgeInsets.symmetric(horizontal: 12), // 내부 패딩
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // 모서리 반경
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1B1B1B), // 시작 색상
              Color(0x001B1B1B), // 끝 색상 (투명)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(
            width: 2,
            style: BorderStyle.solid,
            color: Colors.transparent, // 아래에서 그라데이션으로 덮음
          ),
        ),
        child: Stack(
          children: [
            // 외곽 보더 그라데이션
            Container(
              width: width, // 너비
              height: 48, // 높이
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1A1A1A), // 시작 색상
                    Color(0xFF272727), // 끝 색상
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  ColorChip(
                    width: 24,
                    selected: selectedColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
