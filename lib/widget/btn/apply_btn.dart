import 'package:flutter/material.dart';

class ApplyBtn extends StatelessWidget {
  final String title;

  const ApplyBtn({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32, // 원하는 너비
      height: 76, // 원하는 높이
      child: Stack(
        children: [
          // 외곽 보더 그라데이션
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFF3F4E), // 빨간색
                  Color(0xFF272727), // 회색
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // 내부 배경색
          Container(
            margin: EdgeInsets.all(2), // 보더 두께
            decoration: BoxDecoration(
              color: Color(0xFF9F000C), // 배경색
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
