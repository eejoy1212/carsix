import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';

class AutoBrightCard extends StatelessWidget {
  final String title; // 타이틀
  final String content; // 컨텐츠
  final bool isSwitched; // 스위치 상태
  final Function(bool) onSwitchChanged; // 스위치 상태 변경 함수
  final RangeValues rangeValues; // 레인지 슬라이더 값
  final Function(RangeValues) onRangeChanged; // 레인지 슬라이더 값 변경 함수

  const AutoBrightCard({
    super.key,
    required this.title,
    required this.content,
    required this.isSwitched,
    required this.onSwitchChanged,
    required this.rangeValues,
    required this.onRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: CarsixColors.grey1,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 16, bottom: 16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "자동밝기 ON/OFF", // 받아온 타이틀을 표시
                  style: TextStyle(
                    color: CarsixColors.grey2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 20),
                Switch(
                  value: isSwitched, // 스위치 상태
                  onChanged: onSwitchChanged, // 스위치 상태 변경 시 호출할 함수
                  activeColor: CarsixColors.red2, // 스위치가 켜졌을 때 색상
                ),
              ],
            ),
            const SizedBox(height: 10),
            RangeSlider(
              values: rangeValues, // 레인지 슬라이더 값
              min: 0,
              max: 100,
              divisions: 10,
              onChanged: onRangeChanged, // 레인지 슬라이더 값 변경 시 호출할 함수
              activeColor: CarsixColors.red2, // 활성 슬라이더 색상
              inactiveColor: CarsixColors.grey2, // 비활성 슬라이더 색상
            ),
          ],
        ),
      ),
    );
  }
}
