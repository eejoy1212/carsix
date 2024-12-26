import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class IosInfo extends StatelessWidget {
  const IosInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
              margin: EdgeInsets.only(
                  // left: 115,
                  // right: 115,
                  ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Image.asset(
                      'assets/images/logo_splash.png',
                      width: 40,
                    ),
                    SizedBox(
                      height: 46,
                    ),
                    Text(
                      "블루투스 설정을 이용해서\nCarSix 제품을 찾아 연결해주세요.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CarsixColors.white1,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "블루투스 설정은 아이폰의 설정 메뉴에 있습니다.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CarsixColors.white1,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Image.asset(
                      'assets/images/ios_info.png',
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/main');
                      },
                      child: Text(
                        "건너뛰기",
                        style: TextStyle(
                          color: CarsixColors.white1,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                          letterSpacing: -0.3,
                        ),
                      ),
                    )
                  ])),
        ),
      ),
    );
  }
}
