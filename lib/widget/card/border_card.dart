import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';

class BorderCard extends StatelessWidget {
  final void Function() onTap;
  final double fontSize;
  final double padding;
  final double width;
  final double height;
  final double borderRadius;
  final bool isSelected;
  final String title;
  final Widget widget;
  final bool isTxt;
  final Widget? otherWidget;
  final IconData? txtWithIcon;
  final List<Color> selectedColors;
  final List<Color> unSelectedColors;
  final List<Color> selectedBorderColors;
  final List<Color> unSelectedBorderColors;
  final Color selectedTxtColor;
  final Color unSelectedTxtColor;
  final double borderThickness;
  final AlignmentGeometry borderBegin;
  final AlignmentGeometry borderEnd;
  final MainAxisAlignment titleAlign;
  const BorderCard({
    super.key,
    required this.isSelected,
    required this.title,
    this.fontSize = 12,
    this.height = 37,
    this.borderRadius = 10,
    required this.widget,
    this.width = 100,
    this.padding = 0,
    required this.selectedColors,
    required this.unSelectedColors,
    required this.selectedTxtColor,
    required this.unSelectedTxtColor,
    required this.selectedBorderColors,
    required this.unSelectedBorderColors,
    this.borderThickness = 1,
    this.borderBegin = Alignment.topLeft,
    this.borderEnd = Alignment.bottomCenter,
    required this.onTap,
    this.txtWithIcon = Icons.abc_outlined,
    this.isTxt = true,
    this.otherWidget = const SizedBox.shrink(),
    this.titleAlign = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        child: Stack(
          children: [
            // 테두리와 배경
            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(
                  colors: isSelected ? selectedColors : unSelectedColors,
                  begin: borderBegin,
                  end: borderEnd,
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(borderThickness), // 보더 두께 (2px)
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  gradient: LinearGradient(
                    colors: isSelected
                        ? selectedBorderColors
                        : unSelectedBorderColors,
                    begin: borderBegin,
                    end: borderEnd,
                  ),
                ),
              ),
            ),
            // 텍스트
            Positioned.fill(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isTxt == true
                        ? Row(
                            mainAxisAlignment: titleAlign,
                            children: [
                              SizedBox(
                                  width: titleAlign == MainAxisAlignment.start
                                      ? 10
                                      : 0),
                              Text(
                                title,
                                style: TextStyle(
                                  color: isSelected
                                      ? selectedTxtColor
                                      : unSelectedTxtColor, // 항상 흰색 텍스트
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : (otherWidget ?? SizedBox.shrink()),
                    SizedBox(
                      height: padding,
                    ),
                    widget
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
