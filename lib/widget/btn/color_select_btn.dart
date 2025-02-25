import 'package:carsix/const/color.dart';
import 'package:carsix/widget/chip/color_chip.dart';
import 'package:flutter/material.dart';

class ColorSelectBtn extends StatelessWidget {
  final void Function() onTab;
  final Color selected;
  final int status;
  final bool completed;
  const ColorSelectBtn({
    super.key,
    required this.onTab,
    required this.selected,
    required this.status,
    required this.completed,
  });
  String getTitle() {
    if (status == 0) {
      return "선택 색상 저장하기";
    } else if (status == 1) {
      return "색상 저장완료!";
    } else {
      return "저장된 색상 삭제하기";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        width: 204, // 원하는 너비
        height: 76, // 원하는 높이
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B1B1B), // 시작 색상
              Color(0x001B1B1B), // 투명
            ],
          ),
          border: Border.all(
            width: 2,
            color: Colors.transparent, // 투명한 기본색 (border-image 처리)
          ),
          borderRadius: BorderRadius.circular(20), // 모서리 둥글기 (필요 시 설정)
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.transparent, // 투명한 기본색
            ),
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1A1A1A), // 상단 경계 색상
                Color(0xFF272727), // 하단 경계 색상
              ],
            ),
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColorChip(selected: selected),
              SizedBox(
                width: 10,
              ),
              Text(
                getTitle(),
                style: TextStyle(
                  color: completed ? Color(0xFFA0A0A0) : CarsixColors.white1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
