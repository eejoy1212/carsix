import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';

class IndividualColorBtn extends StatelessWidget {
  final Color color;
  final String light;
  const IndividualColorBtn({
    super.key,
    required this.color,
    required this.light,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(children: [
        Container(
          width: 50,
          height: 50,
          child: Center(
              child: Text(
            "$light/10",
            style: TextStyle(color: Colors.white),
          )),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: const Icon(
            Icons.edit, // 삭제 아이콘 추가
            color: Colors.white,
            size: 20,
          ),
        )
      ]),
    );
  }
}
