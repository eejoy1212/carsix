import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteColorBtn extends StatelessWidget {
  const FavoriteColorBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 16),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: CarsixColors.grey4),
        color: CarsixColors.grey1,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed("/favorite");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "즐겨찾기 추가 하기",
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
