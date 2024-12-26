import 'dart:ui';

import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CircularDashedSlider extends StatelessWidget {
  final double initialValue;
  final Function(double) onChange;
  final Function(double) onChangeEnd;

  CircularDashedSlider({
    required this.initialValue,
    required this.onChange,
    required this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 커스텀 트랙 (점선)
        CustomPaint(
          size: Size(200, 200),
          painter: DashedTrackPainter(),
        ),
        // SleekCircularSlider (Progress Bar)
        SleekCircularSlider(
          innerWidget: (percentage) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  percentage.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "%",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          },
          initialValue: initialValue,
          min: 0,
          max: 100,
          onChange: onChange,
          onChangeEnd: onChangeEnd,
          appearance: CircularSliderAppearance(
            size: 200,
            customWidths: CustomSliderWidths(
              trackWidth: 0, // 트랙 폭 0으로 설정 (커스텀 트랙 사용)
              progressBarWidth: 15,
            ),
            customColors: CustomSliderColors(
              progressBarColor: CarsixColors.primaryRed,
              dotColor: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class DashedTrackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final double dashWidth = 6;
    final double dashSpace = 4;
    final double radius = size.width / 2;

    final Path path = Path()
      ..addArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: radius - 8),
        0,
        2 * 3.141592653589793,
      );

    final PathMetrics pathMetrics = path.computeMetrics();
    for (final PathMetric metric in pathMetrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final Path extractPath =
            metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
