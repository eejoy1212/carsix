import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicColorBtn extends StatelessWidget {
  const MusicColorBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 16),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: CarsixColors.grey4),
        color: CarsixColors.grey1,
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed("/music-color");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "뮤직 컬러 추가 하기",
              style: TextStyle(
                color: CarsixColors.white1,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
