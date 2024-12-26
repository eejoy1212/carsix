import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';

class ApplyBtn extends StatelessWidget {
  final bool nowApply;
  final void Function() onTap;
  final double height;
  final String title;
  final double borderRadius = 20;
  const ApplyBtn({
    super.key,
    required this.onTap,
    required this.nowApply,
    this.height = 76,
    this.title = "이 설정 적용하기",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 32, // 원하는 너비
        height: height, // 원하는 높이
        child: Stack(
          children: [
            // 외곽 보더 그라데이션
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(
                  colors: nowApply
                      ? [
                          Color(0xFF272727), // 시작 색 (검은색)
                          Color(0xFF272727), // 끝 색 (투명한 검은색)
                        ]
                      : [
                          Color(0xFFFF3F4E), // 빨간색
                          Color(0xFF272727), // 회색
                        ],
                  stops: nowApply ? [0.0, 1.0] : null, // nowApply일 때 투명도 조절
                  begin: nowApply ? Alignment.topLeft : Alignment.topLeft,
                  end: nowApply ? Alignment.bottomRight : Alignment.bottomRight,
                ),
              ),
            ),
            // 내부 배경색
            Container(
              margin: EdgeInsets.all(2), // 보더 두께
              decoration: BoxDecoration(
                gradient: nowApply
                    ? LinearGradient(
                        colors: [
                          Color(0xFF1B1B1B), // 시작 색
                          Color(0x001B1B1B), // 끝 색 (투명한 검은색)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
                color: nowApply ? null : Color(0xFF9F000C), // 기존 배경색
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (nowApply)
                      Icon(
                        Icons.check_circle,
                        color: CarsixColors.primaryRed,
                        size: 24,
                      ),
                    if (nowApply)
                      SizedBox(
                        width: 10,
                      ),
                    Text(
                      title,
                      style: TextStyle(
                        color: nowApply ? Color(0xFF6B6B6B) : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
