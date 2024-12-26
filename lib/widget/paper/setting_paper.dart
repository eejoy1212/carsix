import 'package:carsix/widget/card/setting_card.dart';
import 'package:flutter/material.dart';

class SettingPaper extends StatelessWidget {
  final String title; // 타이틀을 받을 변수
  final List<SettingCard> settingCards;
  const SettingPaper(
      {super.key, required this.title, required this.settingCards});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, // 받아온 타이틀을 표시
          style: TextStyle(
            color: Color(0xFF898989),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ...List.generate(
            settingCards.length, (int index) => settingCards[index]),
      ],
    );
  }
}
