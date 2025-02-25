import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';

class CarsixSlider extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final double value;
  final void Function(double value) onChange;
  const CarsixSlider(
      {super.key, this.margin, required this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: CarsixColors.primaryRed,
          inactiveTrackColor:
              CarsixColors.primaryRed.withOpacity(0.2), //CarsixColors.grey2,
          thumbColor: CarsixColors.white1,
          overlayColor: CarsixColors.primaryRed.withOpacity(0.2),
          valueIndicatorColor: CarsixColors.primaryRed, // 라벨의 배경색 변경
          valueIndicatorTextStyle: TextStyle(
            color: CarsixColors.white1, // 라벨의 글자색 변경
            fontSize: 16,
          ),
        ),
        child: Slider(
          value: value, //controller.musicSensitivity.value,
          min: 0.0,
          max: 100.0,
          divisions: 100,
          label: value.toStringAsFixed(
              0), //controller.musicSensitivity.value.round().toString(),
          onChanged: onChange,
        ),
      ),
    );
  }
}
