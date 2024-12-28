import 'package:carsix/const/color.dart';
import 'package:carsix/widget/card/border_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovingBtn extends StatelessWidget {
  final bool isLeft;
  final bool isSelected;
  const MovingBtn({super.key, this.isLeft = false, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BorderCard(
        isSelected: isSelected,
        height: 48,
        borderRadius: 20,
        title: "",
        otherWidget: isLeft
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/left-double-arrow.svg", // 동적으로 아이콘 경로 선택
                    colorFilter: ColorFilter.mode(
                      CarsixColors.white1, // #696969 색상 적용
                      BlendMode.srcIn, // SVG 내부 색상 변경
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "반시계 방향",
                    style: TextStyle(
                      color: CarsixColors.white1,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "시계 방향",
                    style: TextStyle(
                      color: CarsixColors.white1,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    "assets/images/right-double-arrow.svg", // 동적으로 아이콘 경로 선택
                    colorFilter: ColorFilter.mode(
                      CarsixColors.white1, // #696969 색상 적용
                      BlendMode.srcIn, // SVG 내부 색상 변경
                    ),
                  )
                ],
              ),
        isTxt: false,
        widget: Container(),
        selectedColors: [
          Color(0xFF42181B), // 빨간색 시작
          Color(0xFF42181B), // 회색 끝
        ],
        unSelectedColors: [
          Color(0xFF1a1a1a),
          Color(0xFF272727),
        ],
        selectedTxtColor: Colors.white,
        unSelectedTxtColor: Colors.white,
        selectedBorderColors: [
          Color(0xFF42181B), // 배경 시작
          Color(0xFF42181B), // 배경 끝 (투명)
        ],
        unSelectedBorderColors: [
          Color(0xFF1b1b1b),
          Color(0xFF1b1b1b),
        ],
        borderBegin: Alignment.topCenter,
        borderEnd: Alignment.bottomCenter,
        onTap: () {},
      ),
    );
  }
}
