import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';

class RedBtn extends StatelessWidget {
  final VoidCallback onPressed; // onPressed 콜백을 받는 인자
  final Widget title; // onPressed 콜백을 받는 인자
  final double width;
  final double height;
  final Color color;
  final Color? txtColor;
  const RedBtn({
    super.key,
    required this.onPressed, // 필수 인자로 설정
    required this.title, // 필수 인자로 설정
    this.width = 360,
    this.height = 52,
    this.color = CarsixColors.primaryRed,
    this.txtColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed, // 전달받은 onPressed 콜백을 사용
        style: ElevatedButton.styleFrom(
          // primary: color, // 버튼 배경색
          backgroundColor: color,
          textStyle: TextStyle(
            color: txtColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 보더 반경 설정
          ),
        ),
        child: title,
      ),
    );
  }
}
