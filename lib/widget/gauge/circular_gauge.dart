import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';

class CircularGauge extends StatelessWidget {
  final int currentValue;
  final int maxValue;
  final Color progressColor;
  final Color backgroundColor;
  final double width;
  final double fontSize;
  const CircularGauge({
    Key? key,
    required this.currentValue,
    required this.maxValue,
    this.progressColor = Colors.white,
    this.backgroundColor = CarsixColors.primaryRed,
    this.width = 48,
    this.fontSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 배경 원
        Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
        ),
        SizedBox(
          width: width,
          height: width,
          child: CircularProgressIndicator(
            value: currentValue / maxValue,
            strokeWidth: 8,
            backgroundColor: backgroundColor,
            valueColor: AlwaysStoppedAnimation(progressColor),
          ),
        ),
        // 중앙 텍스트
        Text(
          "${(currentValue / 10).toInt()}/${(maxValue / 10).toInt()}",
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
