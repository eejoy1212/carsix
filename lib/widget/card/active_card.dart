import 'package:carsix/widget/card/border_card.dart';
import 'package:flutter/material.dart';

class ActiveCard extends StatelessWidget {
  final void Function() onApply;
  final void Function() onSetting;
  final String title;
  final bool isSelected;
  final bool nowApply;
  const ActiveCard({
    super.key,
    required this.onApply,
    required this.title,
    required this.isSelected,
    required this.onSetting,
    required this.nowApply,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BorderCard(
      borderThickness: 2,
      borderRadius: 20,
      padding: 10,
      width: width,
      height: 90,
      isSelected: isSelected,
      title: title,
      fontSize: 16,
      selectedColors: [
        Color(0xFFE60012), // 빨간색 시작
        Color(0xFF272727), // 회색 끝
      ],
      unSelectedColors: [
        Color(0xFF1a1a1a),
        Color(0xFF272727),
      ],
      selectedBorderColors: [
        Color(0xFF231616), // 배경 시작
        Color(0x00231616), // 배경 끝 (투명)
      ],
      unSelectedBorderColors: [
        Color(0xFF1b1b1b),
        Color(0xFF1b1b1b),
      ],
      selectedTxtColor: Colors.white,
      unSelectedTxtColor: Color(0xFF6b6b6b),
      widget: Container(
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: BorderCard(
                isSelected: nowApply,
                title: nowApply ? "적용중" : "적용하기",
                widget: Container(),
                selectedColors: [
                  Color(0xFF42181B),
                  Color(0xFF42181B),
                ],
                unSelectedColors: [
                  Color(0xFF1A1A1A),
                  // Color(0xFF1A1A1A),
                  Color(0xFFE60012),
                ],
                selectedTxtColor: Colors.white.withOpacity(0.3),
                unSelectedTxtColor: Colors.white,
                selectedBorderColors: [
                  Color(0xFF42181B),
                  Color(0xFF42181B),
                ],
                unSelectedBorderColors: [
                  Color(0xFF1b1b1b),
                  Color(0xFF1b1b1b),
                ],
                borderBegin: Alignment.topCenter,
                borderEnd: Alignment.bottomCenter,
                onTap: onApply,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: BorderCard(
                isSelected: false,
                title: "설정하기",
                widget: Container(),
                selectedColors: [
                  Color(0xFF6F0009), // 빨간색 시작
                  Color(0xFF272727), // 회색 끝
                ],
                unSelectedColors: [
                  Color(0xFF1a1a1a),
                  Color(0xFF272727),
                ],
                selectedTxtColor: Colors.white,
                unSelectedTxtColor: Colors.white,
                selectedBorderColors: [
                  Color(0xFF231616), // 배경 시작
                  Color(0x00231616), // 배경 끝 (투명)
                ],
                unSelectedBorderColors: [
                  Color(0xFF1b1b1b),
                  Color(0xFF1b1b1b),
                ],
                borderBegin: Alignment.topCenter,
                borderEnd: Alignment.bottomCenter,
                onTap: onSetting,
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
