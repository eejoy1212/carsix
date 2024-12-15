import 'package:carsix/const/color.dart';
import 'package:carsix/widget/card/border_card.dart';
import 'package:carsix/widget/chip/color_chip.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final void Function() onApply;
  final void Function() onSetting;
  final String title;
  final bool isSelected;
  final bool nowApply;
  final MainAxisAlignment titleAlign;
  final bool isDisable;
  const CustomCard({
    super.key,
    required this.onApply,
    required this.title,
    required this.isSelected,
    required this.onSetting,
    required this.nowApply,
    required this.isDisable,
    this.titleAlign = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BorderCard(
      titleAlign: titleAlign,
      borderThickness: 2,
      borderRadius: 20,
      padding: 10,
      width: width,
      height: 126,
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ColorChip(
                        selected: isDisable
                            ? Colors.black.withOpacity(0.2)
                            : Colors.red,
                        width: 24,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(isDisable ? "지정 안됨" : "배경색",
                          style: TextStyle(
                            fontSize: 12,
                            color: isDisable
                                ? Color(0xFF636363)
                                : CarsixColors.white1,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      ColorChip(
                        selected: isDisable
                            ? Colors.black.withOpacity(0.2)
                            : Colors.red,
                        width: 24,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(isDisable ? "지정 안됨" : "선택 색상1",
                          style: TextStyle(
                            fontSize: 12,
                            color: isDisable
                                ? Color(0xFF636363)
                                : CarsixColors.white1,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      ColorChip(
                        selected: isDisable
                            ? Colors.black.withOpacity(0.2)
                            : Colors.red,
                        width: 24,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(isDisable ? "지정 안됨" : "선택 색상2",
                          style: TextStyle(
                            fontSize: 12,
                            color: isDisable
                                ? Color(0xFF636363)
                                : CarsixColors.white1,
                          )),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: BorderCard(
                    isSelected: nowApply,
                    title: !nowApply || isDisable ? "적용하기" : "적용중",
                    widget: Container(),
                    selectedColors: [
                      Color(0xFF42181B),
                      Color(0xFF42181B),
                    ],
                    unSelectedColors: isDisable
                        ? [Color(0xFF383838), Color(0xFF383838)]
                        : [
                            Color(0xFF1A1A1A),
                            Color(0xFFE60012),
                          ],
                    selectedTxtColor: Colors.white.withOpacity(0.3),
                    unSelectedTxtColor: Colors.white,
                    selectedBorderColors: [
                      Color(0xFF42181B),
                      Color(0xFF42181B),
                    ],
                    unSelectedBorderColors: isDisable
                        ? [Color(0xFF383838), Color(0xFF383838)]
                        : [
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
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
