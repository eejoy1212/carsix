import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';

class RedBtn extends StatelessWidget {
  final VoidCallback onPressed; // onPressed 콜백을 받는 인자
  final Widget title; // onPressed 콜백을 받는 인자
  final double width;
  const RedBtn({
    super.key,
    required this.onPressed, // 필수 인자로 설정
    required this.title, // 필수 인자로 설정
    this.width = 360,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed, // 전달받은 onPressed 콜백을 사용
        style: ElevatedButton.styleFrom(
          primary: CarsixColors.primaryRed, // 버튼 배경색 노랑으로 설정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 보더 반경 설정
          ),
        ),
        child: title,
      ),
    );
  }
}
