import 'package:carsix/widget/gauge/circular_gauge.dart';
import 'package:flutter/material.dart';

class LedStatusPaper extends StatelessWidget {
  final void Function() onTap;
  const LedStatusPaper({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircularGauge(
            fontSize: 10,
            width: 40,
            currentValue: 20,
            maxValue: 100,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          // width: 48,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 2),

                // width: 16,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Container(
                child: Text(
                  "좌측 센터",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
            ],
          ),
        )
      ],
    );
  }
}
