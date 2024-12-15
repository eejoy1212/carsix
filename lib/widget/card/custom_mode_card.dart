import 'package:carsix/const/color.dart';
import 'package:carsix/widget/chip/color_chip.dart';
import 'package:flutter/material.dart';

class CustomModeCard extends StatelessWidget {
  final void Function() onTap;
  final Color selected;
  final String title;
  const CustomModeCard(
      {super.key,
      required this.selected,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width, // 가로 사이즈
          height: 48, // 세로 사이즈
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1B1B1B), // 시작 색상
                Color(0x001B1B1B), // 투명한 색상 (0%)
              ],
            ),
            border: Border.all(
              width: 2,
              color: Colors.transparent, // Border를 투명 처리
            ),
            borderRadius: BorderRadius.circular(20), // 모서리 둥글기
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ColorChip(
                  selected: selected,
                  width: 24,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: CarsixColors.white1,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A1A1A), // 테두리 시작 색상
                  Color(0xFF272727), // 테두리 끝 색상
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
