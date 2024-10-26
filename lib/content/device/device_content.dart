import 'package:carsix/const/color.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/card/device_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DeviceContent extends StatelessWidget {
  DeviceContent({super.key});
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            //타이틀
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                children: [
                  Text(
                    "디바이스",
                    style: TextStyle(
                        height: 1.6,
                        color: themeController.isDarkMode.value
                            ? CarsixColors.white1
                            : CarsixColors.grey6,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2),
                  ),
                ],
              ),
            ),
            //제조사
            DeviceCard(
              title: '제조사',
              content: '현대',
            ),
            //제조사
            DeviceCard(
              title: '차량',
              content: '그랜저',
            ),
            //차량번호
            DeviceCard(
              title: '차량번호',
              content: '11나8868',
            ),
            //차량번호
            DeviceCard(
              title: '시공점',
              content: '시공점',
            ),
            DeviceCard(
              title: '연결제품',
              content: '연결제품',
            ),
            DeviceCard(
              title: '펌웨어버전',
              content: '펌웨어버전',
            ),
            DeviceCard(
              title: '하드웨어버전',
              content: '하드웨어버전',
            ),
          ],
        ),
      ),
    );
  }
}
