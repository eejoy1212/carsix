import 'package:carsix/const/color.dart';
import 'package:carsix/widget/btn/moving_btn.dart';
import 'package:carsix/widget/slider/carsix_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HiddenCard extends StatelessWidget {
  final String title;
  const HiddenCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Color(0xFF1E1E1E),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Text("전원",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(
                width: 8,
              ),
              Switch(
                activeColor: CarsixColors.primaryRed,
                inactiveTrackColor: CarsixColors.grey9,
                thumbColor: WidgetStatePropertyAll(CarsixColors.white1),
                value: true,
                onChanged: (bool value) {},
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/light-num.svg',
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("발수",
                      style: TextStyle(
                        color: Color(0xFF858585),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ))
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: CarsixSlider(
                value: 1,
                onChange: (double value) {},
              ))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/led-icon.svg',
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("밝기",
                      style: TextStyle(
                        color: Color(0xFF858585),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ))
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: CarsixSlider(
                value: 1,
                onChange: (double value) {},
              ))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 30,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/arrow-seperate.svg',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text("방향",
                        style: TextStyle(
                          color: Color(0xFF858585),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 120,
                child: Row(
                  children: [
                    MovingBtn(
                      isSelected: true,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MovingBtn(
                      isLeft: true,
                      isSelected: false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
