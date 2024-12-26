import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DefaultAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Image.asset('assets/images/nav-arrow-left.png')),
      actions: [
        InkWell(
          onTap: () {},
          child: Text(
            "저장하기",
            style: TextStyle(
              color: Color(0xFFE60012),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 12,
        )
      ],
      title: Text(
        title,
        style: TextStyle(
          color: CarsixColors.white1,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // AppBar 높이 + TabBar 높이
}
